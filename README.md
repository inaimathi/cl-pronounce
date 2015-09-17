# `cl-pronounce`

*English numbers as a service*

### Usage

1. Install [`cl-handlers`](https://github.com/Inaimathi/cl-handlers)
2. Clone this repo into your `~/quicklisp/local-projects`
3. `sbcl --eval '(ql:quickload :cl-pronounce)' --eval '(cl-pronounce:start)'`
4. Send your `http://localhost:5000` requests for number pronounciations


```lisp
inaimathi@self:~$ curl localhost:5000/v1/integer/3
three

inaimathi@self:~$ curl localhost:5000/v1/float/4.75
four point seven five

inaimathi@self:~$ curl localhost:5000/v1/ratio/4/5
four over five

inaimathi@self:~$ curl localhost:5000/v1/magic/39487194387
thirty-nine billion four hundred eighty-seven million one hundred ninety-four thousand three hundred eighty-seven

inaimathi@self:~$ curl localhost:5000/v1/magic/39487194387/23424
thirty-nine billion four hundred eighty-seven million one hundred ninety-four thousand three hundred eighty-seven over twenty-three thousand four hundred twenty-four

inaimathi@self:~$ curl localhost:5000/v1/magic/-9283742444
negative nine billion two hundred eighty-three million seven hundred forty-two thousand four hundred forty-four

inaimathi@self:~$ curl localhost:5000/v1/magic/234432.123
two hundred thirty-four thousand four hundred thirty-two point one two three

inaimathi@self:~$ curl localhost:5000/v1/magic/3.1415
pi

inaimathi@self:~$ curl localhost:5000/v1/magic/-6.2831
negative tau

inaimathi@self:~$ 
```

### What The Fuck?

This is a demo project for [`cl-handlers`](https://github.com/Inaimathi/cl-handlers). It serves a basic Common Lisp [`format` feature](http://www.gigamonkeys.com/book/a-few-format-recipes.html) using `woo` as a means to demonstrate basic handler definition and utility.
