# tkapi-query
De Tweede Kamer API bevragen, met automatisch paginaeren en downloaden van bijbehorende documenten

## Gebruik

Je kan de terminal gebruiken.

`./tkapi.sh <url naar de Tweeke kamer API>`

De bestanden staan data in de `data/` map. De json bestanden zijn het resultaten van het bevragen van de
API. De bijeborende bestanden worden ook in deze map gedownload.

Let op: Alleen de bestanden worden gedownload op het eerste `$expand` niveau.

## Contact

Breyten Ernsting <breyten@openstate.eu>
