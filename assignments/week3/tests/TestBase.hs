{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE  DeriveDataTypeable, DeriveGeneric #-}

module TestBase (List, Student, Comparison, Set, Hw02.Maybe) where 

import Hw02
import Set
import GHC.Generics (Generic)
import Data.Typeable (Typeable)
import Test.QuickCheck.Arbitrary.Generic


-- derive all the type class that is needed

-- type class for student
deriving instance (Typeable Student)
deriving instance (Generic Student)
deriving instance (Eq Student)

instance Arbitrary Student where
  arbitrary = genericArbitrary
  shrink = genericShrink

  
-- type class for list
deriving instance (Typeable a) => (Typeable (List a))
deriving instance (Generic a) => (Generic (List a))
deriving instance (Eq a) => (Eq (List a))

--translate from List to Prelude
l2p :: List a -> [a]
l2p Nil = []
l2p (Cons x xs) = x:(l2p xs)

--translate from Prelude to List
p2l :: [a] -> List a
p2l [] = Nil
p2l (x:xs) = Cons x (p2l xs)


instance (Arbitrary a) => Arbitrary (List a) where
  arbitrary = do ls <- arbitrary; pure $ p2l $ ls
  shrink a =  fmap p2l (shrink $ l2p a)

-- type class for comparasion
deriving instance Eq Comparison

-- define equality on Maybe
deriving instance (Eq a) => Eq (Hw02.Maybe a) 

-- type class for set
instance (Eq a) => Eq (Set a) where 
    set1 == set2 = elems set1 == elems set2
-- because set have an ordering inside of them,
-- therefore there cannot be any Arbitrary defined on set
-- we need to generate a arbitrary list and convert them into set
