# 1 sample t-test

## Example:
In the population the average IQ is 100. A team of scientists wants to test a new medication to see if it has either a positive or negative effect on intelligence, or no effect at all. A sample of 30 participants who have taken the medication has a mean of 140 with a standard deviation of 20. Did the medication affect intelligence?

1. Define H<sub>0</sub> and H<sub>A</sub>

    * H<sub>0</sub>; μ = 100 (mean = 100)
    * H<sub>A</sub>; μ ≠ 100 (mean ≠ 100 to see if there is any difference)        

.

2. α = 0.05

3. Degrees of freedom
    ```
    n – 1 = 30 – 1 = 29
    ```

4. Decision rule. Use t-table (http://www.ttable.org/). 

    * 0.05 & 29; critical value = 2.0452 
        * thus if -2.0452 < t < 2.0452 then accept H<sub>0</sub>

.

5. Calculate test statistic
    * t = (ẋ - μ) / (s / √n)
    * ẋ = 140
    * μ = 100
    * s = 20
    * n = 30

    * t = (140-100) / (20 / √30) = 10.96

.

6. t = 10.96 > 2.0452, therefore reject H<sub>0</sub>

7. Conclusion; medication significantly affected intelligence, t = 10.96, p < 0.05
