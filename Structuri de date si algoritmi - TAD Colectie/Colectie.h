#pragma once

#define NULL_TELEM -1
typedef int TElem;

class IteratorColectie;

class Colectie
{
	friend class IteratorColectie;
private:
	/* aici e reprezentarea */
	int cp;	//capacitatea
	int n;	//dmensiunea
	TElem* e;	//elementele colectiei
	int* f;	//frecventele elementelor din colectie
	void redim();	//pentru redimenionare

public:
		//constructorul implicit
		Colectie();

		//adauga un element in colectie
		void adauga(TElem e);

		//sterge o aparitie a unui element din colectie
		//returneaza adevarat daca s-a putut sterge
		bool sterge(TElem e);

		//verifica daca un element se afla in colectie
		bool cauta(TElem elem) const;

		//returneaza numar de aparitii ale unui element in colectie
		int nrAparitii(TElem elem) const;

		//intoarce numarul de elemente din colectie;
		int dim() const;

		//verifica daca colectia e vida;
		bool vida() const;

		//cerinta din clasa
		// adauga toate elementele colectiei b in colectia curenta
		void adaugaToateElementele(const Colectie & b);

		//returneaza un iterator pe colectie
		IteratorColectie iterator() const;

		// destructorul colectiei
		~Colectie();
};
