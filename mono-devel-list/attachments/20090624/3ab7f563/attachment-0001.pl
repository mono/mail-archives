git checkout $1
dos2unix $1
sed -e 's/ : Assertion//g' < $1 > 2 && mv 2 $1
sed -e 's/AssertEquals (\("[^"]*"\), \(.*\)/Assert.AreEqual (\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/AssertEquals(\("[^"]*"\), \(.*\)/Assert.AreEqual(\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/Assert (\("[^"]*"\), \(.*\)/Assert.IsTrue (\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/Assert(\("[^"]*"\), \(.*\)/Assert.IsTrue(\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/AssertNull (\("[^"]*"\), \(.*\)/Assert.IsNull (\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/AssertNotNull (\("[^"]*"\), \(.*\)/Assert.IsNotNull (\2, \1);/g' < $1 | sed -e 's/);,/,/g' | sed -e 's/); ,/ ,/g' > 2 && mv 2 $1
sed -e 's/Fail (/Assert.Fail (/g' < $1 > 2 && mv 2 $1
sed -e 's/Fail(/Assert.Fail(/g' < $1 > 2 && mv 2 $1
sed -e 's/Assert (\([^"]\)/Assert.IsTrue (\1/g' < $1 > 2 && mv 2 $1


