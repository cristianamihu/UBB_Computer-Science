package repository;

import domain.Entity;
import domain.validators.Validator;

import java.util.HashMap;
import java.util.Optional;

public class InMemoryRepository<ID, E extends Entity<ID>> implements Repository<ID, E> {
    private final Validator<E> validator;
    private final HashMap<ID, E> entities;

    public InMemoryRepository(Validator<E> validator) {
        this.validator = validator;
        entities = new HashMap<ID, E>();
    }

    @Override
    public Optional<E> findOne(ID id){
        if (id == null)
            throw new IllegalArgumentException("Id must be not null!");
        return Optional.ofNullable(entities.get(id));
    }

    @Override
    public Iterable<E> findAll() {
        return entities.values();
    }

    @Override
    public Optional<E> save(E entity) {
        if (entity == null)
            throw new IllegalArgumentException("Entity must be not null!");
        if(entities.get(entity.getId()) != null) {
            return Optional.of(entity);
        }
        if (this.entities.containsKey(entity.getId())) {
            return Optional.of(entity);
        }
        else entities.put(entity.getId(),entity);
        return Optional.empty();
    }

    @Override
    public Optional<E> delete(ID id) {
        if (id == null) {
            throw new IllegalArgumentException("Id must be not null!");
        }
        return Optional.ofNullable(entities.remove(id));
    }

    @Override
    public Optional<E> update(E entity) throws IllegalArgumentException {
        if (entity == null) {
            throw new IllegalArgumentException("Entity must not be null!");
        }
        if (this.entities.containsKey(entity.getId())) {
            this.entities.put(entity.getId(), entity);
            return Optional.empty();
        }
        else {
            return Optional.of(entity);
        }
    }

    @Override
    public long size(){
        return (long)this.entities.size();
    }
}