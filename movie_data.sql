select
  certificate.certificateid as [certificate certificateid]
  ,certificate.certificate
  ,director.directorid as [director directorid]
  ,director.firstname
  ,director.familyname
  ,director.fullname
  ,director.dob
  ,director.dod
  ,director.gender
  ,film.filmid
  ,film.title
  ,cast(film.releasedate as date) as [realease date]
  ,film.directorid as [film directorid]
  ,film.studioid
  ,film.review
  ,film.countryid
  ,film.languageid
  ,film.genreid as [film genreid]
  ,film.runtimeminutes
  ,film.certificateid as [film certificateid]
  ,film.budgetdollars
  ,film.boxofficedollars
  ,film.oscarnominations
  ,film.oscarwins
  ,genre.genreid as [genre genreid]
  ,genre.genre
from
  film
  inner join certificate
    on film.certificateid = certificate.certificateid
  inner join director
    on film.directorid = director.directorid
  inner join genre
    on film.genreid = genre.genreid