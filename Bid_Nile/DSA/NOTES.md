## Prefix Calculation

Index Prefix Value
0 1
1 1
2 2
3 6

Prefix Array => [1, 1, 2, 6]

## Suffix Calculation

Index Suffix Value

0 24
1 12
2 4
3 1

Suffix Array => [24, 12, 4, 1]

## Final Calculation

Index Prefix Suffix Result

0 1 24 24
1 1 12 12
2 2 4 8
3 6 1 6

Output => [24, 12, 8, 6]

## Optimized Solution

Instead of creating separate Prefix and Suffix arrays we Store Prefix products directly inside the output array and Initialize a suffix variable with 1 Traverse the array from right to left and Multiply each output element by the current suffix and Update suffix by multiplying it by the current input element

## Complexity Comparison

Solution Time Complexity Extra Space
Prefix + Suffix Arrays O(n) O(n)
Optimized O(n) O(1)

The output array is excluded from extra space complexity
