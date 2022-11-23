# test-splitting-up-tables-based-on-read-write-frequency


## Principe

L'objectif est de comparer 2 manières de faire : *monolithic* vs *split*

Sont créées 2 bases de données distinctes, l'une avec une table monolithique et l'autre avec deux tables séparées, chacune avec avec 1 million de lignes.

Ensuite sont comparés avec `time` le temps que mettent 1 million de fois un `update` (sur `lastLoggedAt` et `updatedAt`) suivi d'un `select` pour chacune des bases de données. L'objectif est de savoir si la modification de lignes de users influe sur la récupération de lignes de users récupérées par le biais d'un index.


## Procédure

```shell
./create-db-monolithic
./populate-db-monolithic
time ./test-db-monolithic
```

```shell
./create-db-split
./populate-db-split
time ./test-db-split
```

## Valeurs et résultats

Voici les valeurs et résultats obtenus sur mon système.

### Temps

La manière *monolithic* prend `1m9,469` s et la manière *split* prend `51,944` s.

```shell
time ./test-db-monolithic
real    1m9,469s
user    0m0,020s
sys     0m0,009s
```

```shell
time ./test-db-split
real    0m51,944s
user    0m0,022s
sys     0m0,008s
```

### Tailles des différentes tables

La manière *monolithic* prend `507 MB et la manière *split* prend `546` MB.

```
postgres=# select pg_size_pretty(pg_database_size('test_monolithic'));
 pg_size_pretty 
----------------
 507 MB
```

```
test_monolithic=# select pg_size_pretty(pg_relation_size('users'::regclass));
 pg_size_pretty 
----------------
 270 MB
```

```
postgres=# select pg_size_pretty(pg_database_size('test_split'));
 pg_size_pretty 
----------------
 546 MB
```

```
test_split=# select pg_size_pretty(pg_relation_size('users'::regclass));
 pg_size_pretty 
----------------
 128 MB
```

```
test_split=# select pg_size_pretty(pg_relation_size('user-logins'::regclass));
 pg_size_pretty 
----------------
 130 MB
```


## Conclusion

Avec la manière *split* il y a donc une diminution des temps d'accès notable.

Avec la manière *split* il y a donc une augmentation de taille notable mais pas rédhibitoire.

Choisir la manière *split* est donc avantageuse en terme de rapidité sans présenter d'inconvénient.
Et surtout elle permet de regrouper dans une table dédiée `user-logins` toutes les données relatives au login, ce qui a beaucoup de sens en terme d'architecture notamment pour faciliter la compréhension et le travail des développeurs.


## Articles parlant du sujet

* https://www.postgresql.org/message-id/1421860186723-5834911.post%40n5.nabble.com
* https://charlesnagy.info/it/postgresql/split-or-leave-frequently-updated-column-in-postgresql
