#include "IteratorColectie.h"
#include "Colectie.h"
#include <exception>

using namespace std;


IteratorColectie::IteratorColectie(const Colectie& c): col(c) {	//Complexitate timp: Theta(1)
	//seteaza iteratorul pe prima pozitie
	this->curent_index = 0;
	this->curent_frecventa = 0;
}

void IteratorColectie::prim() {	//Complexitate timp: Theta(1)
	//reseteaza iteratorul pe prima pozitie, primul element
	this->curent_index = 0;
	this->curent_frecventa = 0;
}


void IteratorColectie::urmator() {	//Complexitate timp: Theta(1)
	//muta iteratorul pe urmatoarea pozitie, urmatorul element
	/*if (this->curent_index >= this->col.n)
		throw exception();
	else {
		if (this->curent_frecventa < this->col.f[this->curent_index])
			this->curent_frecventa++;
		else {
			this->curent_index++;
			this->curent_frecventa = 1;
		}
	}
	*/
	this->curent_frecventa++;
	if (this->curent_frecventa == this->col.f[this->curent_index]) {
		this->curent_frecventa = 0;
		this->curent_index++;
	}
}


bool IteratorColectie::valid() const {	//Complexitate timp: Theta(1)
	//verifica daca iteratorul indica spre un element al vectorului
	/*if (this->curent_index >= this->col.n)
		return false;
	else
		return true;
	*/
	return this->curent_index < this->col.n && this->curent_frecventa < this->col.f[this->curent_index];
}


TElem IteratorColectie::element() const {	//Complexitate timp: Theta(1)
	//returneaza elementul curent din colectie
	if (this->valid())
		return this->col.e[this->curent_index];
	return -1;
}
