//
// Copyright (c) 2014, Intel Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// Neither the name of the Intel Corporation nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//

//
// @file riso.cpp
// @brief LI RISO App
//
// @author Daniel Lustig
//

#include <cstdlib>
#include <iostream>
#include <cassert>
#include <sstream>
#include <set>
#include "li.hpp"

/******************************************************************************/
/*
 * Example libLI workload: RISO - Random in, serial out
 *
 *                <id, val>
 *   /---------------------------------------\
 *   |                    /-------------\    |
 *   |   /------\ id   /->| RandomDelay |----/
 *   |   |      |-----/   \-------------/  
 *   \-->| RISO |
 *       |      |-----\   /-------\
 *       \------/ val  \->| Drain |
 *                        \-------/
 *
 *  RISO:        Random in of <token, val>, serial out of tokens and vals 
 *               separately
 *  RandomDelay: Receives tokens from RISO, outputs <token, val> in randomized 
 *               order
 *  Drain:       Sinks all values output from the RISO
 */
/******************************************************************************/

template<class T>
class RISO
{
	public:
		typedef std::pair<int, T> int_plus_T;

		RISO();

		li::LINC_SEND<int> next_id;
		li::LINC_SEND<T>   oldest_val;

		li::LINC_RECV<int_plus_T> completed;

	private:
		li::LINC_SEND<std::string> debug;

		int head;
		int cmask;
		T vals[32];
		bool starting;

		// Startup
		bool canStartup() const;
		void doStartup();

		// Complete
		bool canComplete() const;
		void doComplete();

		// SendOldest
		bool canSendOldest() const;
		void doSendOldest();
};

template<class T>
RISO<T>::RISO() : head(0), cmask(0), starting(true)
{
	li::Scheduler<RISO> *s =
		new li::StaticPriorityScheduler<RISO>(this);

	s->RegisterRule(&RISO<T>::canStartup, &RISO<T>::doStartup);
	s->RegisterRule(&RISO<T>::canComplete, &RISO<T>::doComplete);
	s->RegisterRule(&RISO<T>::canSendOldest, &RISO<T>::doSendOldest);

	li::Name(debug, "STDERR");
}

template<class T>
bool RISO<T>::canStartup() const
{
	return starting && !next_id.IsFull();
}

template<class T>
void RISO<T>::doStartup()
{
	std::stringstream s;
	s << "RISO:Startup " << head;
	debug.Enqueue(s.str());

	next_id.Enqueue(head);
	head++;
	if (head == 32)
	{
		starting = false;
		head = 0;
	}
}

template<class T>
bool RISO<T>::canComplete() const
{
	return !completed.IsEmpty();
}

template<class T>
void RISO<T>::doComplete()
{
	int_plus_T tuple = completed.Peek();
	completed.Dequeue();

	int index = tuple.first;
	T value = tuple.second;

	assert(!(cmask & (1 << index)));

	vals[index] = value;
	cmask |= (1 << index);

	std::stringstream s;
	s << "RISO:Complete " << index << ":" << value << "(0x" << std::hex
			<< cmask << std::dec << ")";
	debug.Enqueue(s.str());
}

template<class T>
bool RISO<T>::canSendOldest() const
{
	return ((1 << head) & cmask) && !oldest_val.IsFull() &&
		!next_id.IsFull();
}

template<class T>
void RISO<T>::doSendOldest()
{
	cmask &= ~(1 << head);

	std::stringstream s;
	s << "RISO:Send " << head << ":" << vals[head] << "(0x" << std::hex
			<< cmask << std::dec << ")";
	debug.Enqueue(s.str());

	T value = vals[head];
	oldest_val.Enqueue(value);
	next_id.Enqueue(head);

	head++;
	if (head == 32)
		head = 0;
}

/******************************************************************************/

class RandomDelayModule
{
	public:
		typedef std::pair<int, std::string> int_plus_string;

		RandomDelayModule();

		li::LINC_SEND<int_plus_string> output;

		li::LINC_RECV<int> id_in;

	private:
		li::LINC_SEND<std::string> debug;

		bool can_receive_msg() const;
		void do_receive_msg();

		bool can_drain_queue() const;
		void do_drain_queue();

		// The set of IDs that don't get sent back out right away
		std::set<int> queued_ids;

		int count;
};

RandomDelayModule::RandomDelayModule() : count(0)
{
	li::StaticPriorityScheduler<RandomDelayModule> *s =
		new li::StaticPriorityScheduler<RandomDelayModule>(this);

	s->RegisterRule(&RandomDelayModule::can_receive_msg,
			&RandomDelayModule::do_receive_msg);
	s->RegisterRule(&RandomDelayModule::can_drain_queue,
			&RandomDelayModule::do_drain_queue);

	li::Name(debug, "STDERR");
}

bool RandomDelayModule::can_receive_msg() const
{
	return !id_in.IsEmpty();
}

void RandomDelayModule::do_receive_msg()
{
	int idx = id_in.Peek();

	queued_ids.insert(idx);
	id_in.Dequeue();

	std::stringstream s;
	s << "RandomDelay:Receive " << idx;
	debug.Enqueue(s.str());

	count++;
}

bool RandomDelayModule::can_drain_queue() const
{
	return !queued_ids.empty() && !output.IsFull();
}

void RandomDelayModule::do_drain_queue()
{
	std::set<int>::iterator iter = queued_ids.begin();
	while(rand() % 5 && iter != queued_ids.end())
		iter++;
	if (iter == queued_ids.end())
		iter = queued_ids.begin();

	int idx = *iter;
	queued_ids.erase(iter);

	std::stringstream s;
	s << "RandomDelay:Output " << idx;
	debug.Enqueue(s.str());

	std::stringstream ss;
	ss << "Token " << idx;
	std::string val = ss.str();

	std::pair<int, std::string> tuple = std::make_pair(idx, val);
	output.Enqueue(tuple);
}

/******************************************************************************/

template<class T> class DrainModule
{
	public:
		DrainModule();

		li::LINC_RECV<T> input;

	private:
		li::LINC_SEND<std::string> output;
		li::LINC_SEND<std::string> debug;

		bool canDrain() const;
		void doDrain();

		int count;
};

template<class T> DrainModule<T>::DrainModule() : count(0)
{
	li::StaticPriorityScheduler<DrainModule> *s =
		new li::StaticPriorityScheduler<DrainModule>(this);

	s->RegisterRule(&DrainModule<T>::canDrain, &DrainModule<T>::doDrain);

	li::Name(output, "STDOUT");
	li::Name(debug, "STDERR");
}

template<class T>
bool DrainModule<T>::canDrain() const
{
	return !input.IsEmpty();
}

template<class T>
void DrainModule<T>::doDrain()
{
	std::stringstream s;
	s << "Drain:Drain " << input.Peek() << "(" << count << ")";
	debug.Enqueue(s.str());

	input.Dequeue();

	count++;
	if (count == 64)
		li::Quiesce();
}

/******************************************************************************/

class RISOTestbench : public li::StandardContext
{
	public:
		void Elaborate();
};

void RISOTestbench::Elaborate()
{
	RISO<std::string> *riso = new RISO<std::string>();
	RandomDelayModule *delayer = new RandomDelayModule();
	DrainModule<std::string> *drain = new DrainModule<std::string>();

	li::Connect(riso->next_id, delayer->id_in);
	li::Connect(riso->oldest_val, drain->input);
	li::Connect(delayer->output, riso->completed);
}

RISOTestbench testbench;
li::Context *li::context = &testbench;

