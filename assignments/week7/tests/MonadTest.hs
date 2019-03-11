module MonadTest where

    import MonadTestType as MTT

    import Test.Tasty (testGroup, TestTree)
    import Test.Tasty.HUnit (assertEqual, testCase, assertBool, (@=?))
    import Test.Tasty.QuickCheck

    -- Using BB to refer BareBonesLast
    -- BB.List(..), BB.Pair(..), BB.Maybe(..), BB.Either(..), BB.Identity(..), BB.Trival(..)

    monadTest = testGroup "Monad Test" [
            listLeftTest,
            listRightTest,
            listAssociationTest,
            maybeLeftTest,
            maybeRightTest,
            maybeAssociationTest,
            eitherLeftTest,
            eitherAssociativityTest,
            identityLeftTest,
            identityAssociativityTest,
            printerLeftTest,
            printerRightTest,
            printerAssociativityTest
        ]

    --list test
    incrementAndRetList :: Integer -> List Integer
    incrementAndRetList x = Cons (x+1) Nil

    doubleAndRetList :: Integer -> List Integer
    doubleAndRetList x = Cons (x*2) Nil


    
    listLeftTest = testProperty "Test left identity law on list" $
        \l -> let lst = l::Integer in 
            (return lst >>=  incrementAndRetList) == (incrementAndRetList lst)

    listRightTest = testProperty "Test right identity law on list" $
        \l -> let lst = l::(List Integer) in
            (lst >>= return) == lst

    listAssociationTest = testProperty "Test accociativity law on list" $
        \l -> let lst = l::(List Integer) in
            (lst >>= (\x -> incrementAndRetList x >>= doubleAndRetList)) == (lst >>= incrementAndRetList >>= doubleAndRetList) 


    --maybe test
    maybeLeftTest = testProperty "Test left identity law on maybe types" $
        \m -> let may = m::Integer in 
            (return may >>= (\x -> MTT.Just (x+1))) ==  (\x -> MTT.Just (x+1)) may

    maybeRightTest = testProperty "Test right identity law on maybe types" $
        \m -> let may = m::(MTT.Maybe Integer) in
            (may >>= return) == may

    maybeAssociationTest = testProperty "Test accociativity law on maybe types" $
        \m -> let may = m::(MTT.Maybe Integer) in
            (may >>= (\y -> ((\x -> MTT.Just (x+1)) y) >>=  (\x -> MTT.Just (x*2)))) == (may >>= (\x -> MTT.Just (x+1)) >>= (\x -> MTT.Just (x*2)))

    --Either test
    eitherLeftTest = testProperty "Test left identity law on Either types" $
        \e -> let either = e::Integer in
            (return either >>= (\x -> MTT.Right (1+x)) :: MTT.Either Bool Integer) == MTT.Right (1+e)

    eitherRightTest = testProperty "Test right identity law on Either types" $
        \e -> let either = e::(MTT.Either Bool Integer) in
            (either >>= return) == either

    eitherAssociativityTest = testProperty "Test accociativity law on Either types" $
        \e -> let either = e::(MTT.Either Bool Integer) in
            (either >>= (\y -> ((\x -> MTT.Right (1+x)) y) >>= (\x -> MTT.Right (2*x)))) == (either >>= (\x -> MTT.Right (1+x)) >>= (\x -> MTT.Right (2*x)))

    --Identity tests
    runIdentity' (MTT.Identity a) = a


    identityLeftTest = testProperty "Test left identity law on Identity types" $
        \i -> let id = i::(MTT.Identity Integer) in
            (id >>= (\x -> MTT.Identity (x+1))) == (\x -> MTT.Identity (1 + (runIdentity' x))) id

    identityRightTest = testProperty "Test right identity law on Identity types" $
        \i -> let id = i::(MTT.Identity Integer) in
            (id >>= return) == id

    identityAssociativityTest = testProperty "Test accociativity law on Identity types" $
        \i -> let id = i::(MTT.Identity Integer) in
            (id >>= (\y -> ((\x -> MTT.Identity (x+1)) y) >>= (\x -> MTT.Identity (x*2)))) == (id >>= (\x -> MTT.Identity (x+1)) >>= (\x -> MTT.Identity (x*2)))


    --Trival tests
    trivalLeftTest = testProperty "Test left identity law on Trival types" $
        \t -> let tri = t::(MTT.Trival Integer) in
            (tri >>= (\x -> MTT.NoA)) == (\x -> MTT.NoA) tri

    trivalRightTest = testProperty "Test right identity law on Trival types" $
        \t -> let tri = t::(MTT.Trival Integer) in
            (tri >>= return) == tri

    trivalAssociativityTest = testProperty "Test associativity law on Trival types" $
        \t -> let tri = t::(MTT.Trival Integer) in
            (tri >>= (\y -> ((\x -> MTT.NoA) y) >>= (\x -> MTT.NoA))) == (tri >>= (\x -> MTT.NoA) >>= (\x -> MTT.NoA))

    --Printer Monad Tests
    printerLeftTest = testProperty "Test left identity law on Printer Monad" $
        \resIn -> let res = resIn :: Integer in
            (return res >>= (\inp -> MTT.PrinterMonad [even inp] inp)) == (MTT.PrinterMonad [even res] res)
    
    printerRightTest = testProperty "Test left identity law on Printer Monad" $
        \prIn -> let printer = prIn :: MTT.PrinterMonad Bool Integer in
            (printer >>= return) == (printer)

    printerAssociativityTest = testProperty "Test associativity law on Printer Monad" $
        \prIn -> let printer = prIn :: MTT.PrinterMonad Bool Integer in
            (printer 
                >>= (\inp -> MTT.PrinterMonad [even inp] inp)
                >>= (\inp -> MTT.PrinterMonad [odd inp] inp)
                ) == (
                    printer 
                        >>= (\inp -> MTT.PrinterMonad [even inp] inp
                            >>= (\inp -> MTT.PrinterMonad [odd inp] inp))
                    )
    
                        