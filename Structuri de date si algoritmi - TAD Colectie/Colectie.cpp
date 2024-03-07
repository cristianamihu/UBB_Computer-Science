#include "Colectie.h"
#include "IteratorColectie.h"
#include <exception>

using namespace std;


Colectie::Colectie() {	//Complexitate timp: Theta(1)
	this->cp = 100;		//setam capacitatea
	this->n = 0;	//setam numarul de elemente din colectie
	this->e = new TElem[this->cp];	//alocam spatiu de memorare pentru vector
	this->f = new int[this->cp];	//alocam spatiu de memorare pentru vectorul de perechi (cu element,frecventa)
}


void Colectie::redim() {   //Complexitate timp: Theta(n)
	//redimensionam vectorul dinamic in momentul in care nu mai este spatiu pentru elemente noi
	this->cp = 2 * this->cp;	//dublam capacitatea
	//alocam un spatiu de capacitate dubla pentru ambii vectori
	TElem* eNou = new int[this->cp];
	int* fNou = new int[this->cp];
	//copiem vechile valori din ambii vectori in noua zona
	for (int i = 0; i < this->n; i++)
	{
		eNou[i] = this->e[i];
		fNou[i] = this->f[i];
	}
	//eliberam vechiile zone ale vectorilor
	delete[] this->e;
	delete[] this->f;
	//vectorii indica spre noua lor zona
	this->e = eNou;
	this->f = fNou;
}


void Colectie::adauga(TElem elem) { 
	/*Complexitate timp: O(n)
	*   Caz favorabil: Theta(n), Caz defavorabil: Theta(n), Caz mediu: Theta(n)
	*/
	//se adauga un nou element la colectie, daca nu mai este loc se face redimensionarea vectorului 
	//n este numarul de elemente distincte din colectie
	if (this->n == this->cp) //daca s-a atins capacitatea maxima, redimensionam
		redim();
	if (not cauta(elem)) {
		this->e[this->n] = elem;
		this->f[this->n] = 1;
		this->n++;
	}
	else
		for (int i = 0; i < this->n; i++)
			if (this->e[i] == elem)
				this->f[i]++;
}


bool Colectie::sterge(TElem elem) {
	/*Complexitate timp: O(n)
	*   Caz favorabil: Theta(1), Caz defavorabil: Theta(n), Caz mediu: Theta(n)
	*/
	//sterge un element din colectie
	//returneaz adevarat daca elementul din colectie s-a putut sterge
	if (cauta(elem)) {
		for (int i = 0; i < this->n; i++)
			if (this->e[i] == elem) {
				this->f[i]--;
				if (this->f[i] == 0) {
					for (int j = i; j < this->n; j++) {
						this->e[j] = this->e[j + 1];
						this->f[j] = this->f[j + 1];
					}
					this->n--;
				}
				return true;
			}
	}
	return false;
}


bool Colectie::cauta(TElem elem) const {
	/*Complexitate timp: 0(n)
	*   Caz favorabil: Theta(1), Caz defavorabil: Theta(n), Caz mediu: Theta(n)
	*/
	//returneaza fals daca nu exista elementul cautat in colectie si adevarat daca exista
	for (int i = 0; i < this->n; i++)
		if (this->e[i] == elem)
			return true;
	return false;
}

int Colectie::nrAparitii(TElem elem) const {
	/*Complexitate timp: O(n)
	*   Caz favorabil: Theta(1), Caz defavorabil: Theta(n), Caz mediu: Theta(n)
	*/
	//returneaza numarul de aparitii al unui element din colectie
	for (int i = 0; i < this->n; i++)
		if (this->e[i] == elem)
			return this->f[i];
	return 0;
}


int Colectie::dim() const {   //Complexitate timp: Theta(n)
	//returneaza dimensiunea colectiei
	int numar_elemente = 0;
	for (int i = 0; i < this->n; i++)
		numar_elemente = numar_elemente + this->f[i];
	return numar_elemente;
}


bool Colectie::vida() const {	//Complexitate timp: Theta(1)
	//returneaza fals daca colectia nu este vida si adevarat daca este
	if (this->n == 0)
		return true;
	return false;
}


void Colectie::adaugaToateElementele(const Colectie& b) {	//Complexitate timp: O(n*n)
	// adauga toate elementele colectiei b in colectia curenta
	/*for (int i = 0; i < this->n; i++) {
		if (cauta(b.e[i]))
			while (nrAparitii(b.e[i]) != 0)
			{
				adauga(i+b.e[i]);
				this->f[i]--;
			}
	}
	*/
	IteratorColectie i = b.iterator();
	while (i.valid()) {
		TElem elem = i.element();
		int f = b.nrAparitii(elem);
		for (int j = 0; j < f; j++) {
			adauga(elem);
		}
		i.urmator();
	}
}


IteratorColectie Colectie::iterator() const {	//Complexitate timp: Theta(1)
	return  IteratorColectie(*this);
}


Colectie::~Colectie() {	  //Complexitate timp: Theta(1)
	//eliberam zona de memorare alocata vectorului de elemente ale colectei
	delete[] this->e;
}
