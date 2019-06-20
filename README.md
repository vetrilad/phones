# Interview task
### Task

When a client requests for a phone number, it allots one of the available numbers to them.
Some clients may want fancy numbers, so they can specifically ask for a number to be allotted
to them. If the requested number is available then the system assigns it to them, otherwise, the
system allots any available number.

The system need not have to know which number is allotted to which client. The same client
may make successive requests and get multiple phone numbers for himself, but the system is
not bothered. At any point of time, the system only knows which phone numbers are allotted
and which phone numbers are free.

The system should allow for basic authentication (session or token is fine), and the endpoint for
requesting a phone number should only be accessible by authenticated users. You will need to
create a User model which contains a name, email address, and password to handle this
functionality

### How to use it
Server requires some external dependancies to execute.

Install dependancies

`bundle install`

Create database

`RACK_ENV=development rake db:setup`

Run

`bundle exec rackup` to start the development server

### Example api calls:

Create Request
```
curl --cookie-jar - -d "username=admin&admin@engineer.ai&password=admin" -X POST http://localhost:9292/create_user
```
Response
```
...
#HttpOnly_localhost	FALSE	/	FALSE	0	rack.session	BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiRTI3ZjJiMjVjYWRlNjk2NGRlYzdk%0AZDkyNjBhOGY0NTQ5OWMwZmJmMWQzY2MyYjUzODdjYWU5NWRlZmY1NTA1YWYG%0AOwBGSSIJY3NyZgY7AEZJIjFTTXdyVGNsNDE4YmNTcW1WNHJpSmFOTnBydG02%0AL0hQeFBWcDFpTm8wdUtVPQY7AEZJIg10cmFja2luZwY7AEZ7BkkiFEhUVFBf%0AVVNFUl9BR0VOVAY7AFRJIi01NmMxYTdkOWI2YjdjZjUyMTdkNTk1YjM4MjVm%0AZDc4MjI5MmIyNGNjBjsARg%3D%3D%0A--515011c492dc4aa737f8b01bf1fe7f29e59d2dbc
```

Obtain session Request
```
curl --cookie-jar -  -d "username=admin&password=admin" -X POST http://localhost:9292/sign_in
```
Response
```
...
#HttpOnly_localhost	FALSE	/	FALSE	0	rack.session	BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiRTNiNzAxYTdjZTAwNmI4MTU2OGEw%0ANTE3MDUwYzA4NmMxYWFlMjA5ZDM0ZTlhZDhmZjk2NjdmOTg5OWRjMTZiYjQG%0AOwBGSSIJY3NyZgY7AEZJIjFRMGhsd29KdldsVXlTM0ROZVlFTFExRUg0VXY2%0AMGN2eTZzaDBQU1dVMmRZPQY7AEZJIg10cmFja2luZwY7AEZ7BkkiFEhUVFBf%0AVVNFUl9BR0VOVAY7AFRJIi01NmMxYTdkOWI2YjdjZjUyMTdkNTk1YjM4MjVm%0AZDc4MjI5MmIyNGNjBjsARg%3D%3D%0A--455a3c69a8288083233f2bac8e1c6973c726172c
```

Get random number Request
```
curl -v -d "" -b "rack.session=BAh7B0kiDHVzZXJfaWQGOgZFRmkGSSIPc2Vzc2lvbl9pZAY7AFRJIkViM2Jl%0AY2VhMTg5MDkxNzI4NzEzZDAzODAwNDExMTRhN2U1NzZmYzBmYWI2ZmJmZGI0%0AYzY3MjkwMTVkMjQ4MjAzBjsARg%3D%3D%0A--77505ef89ceb1f9dc2f08166eee13308d9e8010b" -X POST http://localhost:9292
```

Response
```
...
{"allocated_number":"111-111-1146"}
...
```

Get custom number Request
```
curl -v -d "" -b "rack.session=BAh7B0kiDHVzZXJfaWQGOgZFRmkGSSIPc2Vzc2lvbl9pZAY7AFRJIkViM2Jl%0AY2VhMTg5MDkxNzI4NzEzZDAzODAwNDExMTRhN2U1NzZmYzBmYWI2ZmJmZGI0%0AYzY3MjkwMTVkMjQ4MjAzBjsARg%3D%3D%0A--77505ef89ceb1f9dc2f08166eee13308d9e8010b" -X POST http://localhost:9292/8987659876
```

Response
```
...
{"allocated_number":"898-765-9876"}
```

### How to run the tests

Install dependancies

`bundle install`

Create database

`RACK_ENV=test rake db:setup`

And run the tests

`rspec -f d`
