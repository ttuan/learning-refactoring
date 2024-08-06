## SOLID Object Oriented Design by Sandi Metz

Source: Sandi Metz Talk: https://www.youtube.com/watch?v=v-2yFMzxqwU&ab_channel=Confreaks

- About the code
  - What if the ftp host/login/password changes?
  - What if I need to create another job like this?

- About the test
  - What if I don't want to ftp a file in every testss

- If testing seems hard - examine your design
- *TDD will punish you if you don't understand design*.


RED - GREEN - REFACTOR

1. Is it DRY?
2. Does it have one responsibility?
3. Does everything in it change at the same rate?
4. Does it depend on things that change less often than it does?

=> Ask this questions when you are in GREEN phase. If the answer is YES => You should change your code.


### Triangle of Responsibility Refactoring

1. Refactor 
2. Extract
3. Inject

=> 1 => 2 => 3 => 1 => ....

Don't guess! Follow the rule and see what happen


Refactor, not because you know the abstraction, but because you want to find it.

After refactor: The order of dependencies: 

1. PatentJob
2. FtpDownloader
3. Config
4. patent.yml

<===== Less ============ Likelihood of Change =================== More =======>
                always depend on things on your left.


### The Bottom Line

TDD is not enough.
DRY is not enough.

Design because you expect you application to succeed and the future to come.


Robert Martin: https://staff.cs.utu.fi/~jounsmed/doos_06/material/DesignPrinciplesAndPatterns.pdf
Steve Freeman and Nat Pryce http://www.growing-object-oriented-software.com/
