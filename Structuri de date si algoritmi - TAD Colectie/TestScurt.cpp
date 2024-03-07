#include "TestScurt.h"
#include <assert.h>
#include "Colectie.h"
#include "IteratorColectie.h"


void testAll() { //apelam fiecare functie sa vedem daca exista
	Colectie c;
	assert(c.vida() == true);
	assert(c.dim() == 0); //adaug niste elemente
	c.adauga(5);
	c.adauga(1);
	c.adauga(10);
	c.adauga(7);
	c.adauga(1);
	c.adauga(11);
	c.adauga(-3);
	assert(c.dim() == 7);
	assert(c.cauta(10) == true);
	assert(c.cauta(16) == false);
	assert(c.nrAparitii(1) == 2);
	assert(c.nrAparitii(7) == 1);
	assert(c.sterge(1) == true);
	assert(c.sterge(6) == false);
	assert(c.dim() == 6);
	assert(c.nrAparitii(1) == 1);
	IteratorColectie ic = c.iterator();
	ic.prim();
	while (ic.valid()) {
		TElem e = ic.element();
		ic.urmator();
	}	 
}


void test_adaugaToateElementele(){

	Colectie c;
	Colectie b;
	c.adauga(1);
	c.adauga(2);
	c.adauga(3);
	assert(c.dim() == 3);
	b.adauga(4);
	b.adauga(2);
	b.adauga(5);
	assert(b.dim() == 3);
	c.adaugaToateElementele(b);
	assert(c.nrAparitii(1) == 1);
	assert(c.nrAparitii(2) == 2);
	assert(c.nrAparitii(3) == 1);
	assert(c.nrAparitii(4) == 1);
	assert(c.nrAparitii(5) == 1);
}

























/*
assert(b.dim() == 8);
assert(b.cauta(25) == true);
assert(b.cauta(1) == true);
assert(b.cauta(3) == true);
assert(b.cauta(8) == true);
b.adaugaToateElementele(c);
assert(b.dim() == 13);
c.adaugaToateElementele(b);
assert(c.dim() == 18);
assert(c.cauta(11) == true);
assert(c.cauta(13) == true);
assert(c.cauta(18) == true);
*/