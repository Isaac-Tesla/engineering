# 2-sample t-test (Student’s test, Welch’s t-test, Unpaired t-test)

## Example:
Do Japanese cars get better mpg than American cars?

1. Define H<sub>0</sub> and H<sub>A</sub>
    * H<sub>0</sub>; μ<sub>mpg(Japanese)</sub> = μ<sub>mpg(American)</sub>
    * H<sub>A</sub>; μ<sub>mpg(Japanese)</sub> ≠ μ<sub>mpg(American)</sub>

</br>

2. Assumptions
    * j = individual cars in the 2 sample groups.
    * Japanese and American cars are statistically independent from each other.


    Y<sub>(Japanese) j</sub> ~ N(μ<sub>1</sub>, σ²) : independent and identically distributed from a normal distribution with a mean and a variance.

    Y<sub>(American) j</sub> ~ N(μ<sub>2</sub>, σ²) : independent and identically distributed from a normal distribution with a DIFFERENT mean but the same variance.

</br>

3. Test Statistic
    (Ŷ<sub>1</sub> - Ŷ<sub>2</sub> – (μ<sub>1</sub> - μ<sub>2</sub>)) / SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>)

    * Ŷ<sub>1</sub> = sample average mpg of Japanese cars
    * Ŷ<sub>2</sub> = sample average mpg of American cars
    * μ<sub>1</sub> & μ<sub>2</sub> = true means
    * n = number of cars in each group
    * sp = pooled standard deviation    

    </br>

    SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>) = sp √ ((1/n<sub>1</sub>) + (1/n<sub>2</sub>))

    </br>
    
    sp = √ ( (n<sub>1</sub> – 1)s<sup>2</sup><sub>1</sub> + (n<sub>2</sub> – 1)s<sup>2</sup><sub>2</sub> ) / (n<sub>1</sub> + n<sub>2</sub> – 2)

    </br>

    In order to construct a p-value we assume H<sub>0</sub> is true. When they are equal :
    * t = (Ŷ<sub>1</sub> - Ŷ<sub>2</sub> – (μ<sub>1</sub> - μ<sub>2</sub>)) / SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>)
    * t = (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>) / SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>)
    * t = 1 / SE
    * t ~ t <sub>n1 + n2 – 2</sub>

    </br>

    p-value is :
    * p( | t <sub>n1 + n2 – 2</sub> | > | t | ) = p( | t <sub>n1 + n2 – 2</sub> | > | t | ) + p( | t <sub>n1 + n2 – 2</sub> | < - | t | )

    </br>

    Area chosen = 1.5

</br>

4. Calculation

    <table>
    <thead>
        <tr>
            <th>Car</th>
            <th>n (sample size)</th>
            <th>Mean</th>
            <th>SD</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Japanese</td>
            <td>79</td>
            <td>30.5</td>
            <td>6.11</td>
        </tr>
        <tr>
            <td>American</td>
            <td>249</td>
            <td>20.1</td>
            <td>6.41</td>
        </tr>
    </tbody>
    </table>

    </br>

    sp = √ ( (n<sub>1</sub> – 1)s<sup>2</sup><sub>1</sub> + (n<sub>2</sub> – 1)s<sup>2</sup><sub>2</sub> ) / (n<sub>1</sub> + n<sub>2</sub> – 2)

    sp = √ ( (79 – 1)(-6.112) + (249 – 1)(-6.412) ) / (79 + 249 – 2) = 6.34

    </br>

    SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>) = sp √ ((1/n<sub>1</sub>) + (1/n<sub>2</sub>))   

    SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>) = 6.34 √ ((1 / 79) + (1 / 249)) = 0.82 

    t = (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>) / SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>)    

    t = 30.5 – 20.1 / 0.82 = 12.6   

    </br>

    Probability on both sides as extreme : p(t<sub>326</sub> > |12.6|) < 0.0001 (using t-table)

    Alternative is to construct a 100(1- α)% confidence interval.

    Formula:

    Ŷ<sub>1</sub> - Ŷ<sub>2</sub> ± t <sub>n1 + n2 – 2</sub> (1 - α/2) SE (Ŷ<sub>1</sub> - Ŷ<sub>2</sub>)  
    
    where ± indicates plus and minus and t<sub>df</sub>(1- α/2) is the value such that 

    p(t<sub>df</sub> < t<sub>df</sub>(1- α/2)) = 1- α/2. If α = 0.05 and df = 326 (n<sub>1</sub> – 1 + n<sub>2</sub> - 1), then

    t<sub>df</sub>(1- α/2) = 1.97 (from t-table - http://www.ttable.org/)

    </br>

    The 95% confidence interval is:

    30.5 – 20.1 ± 1.97 * 0.82 = (8.73, 11.9)

    We are 95% confident that, on average, Japanese cars get between 8.73 and 11.9 more mpg than American cars.


5. Conclusion   

    Mean miles per gallon of Japanese cars is significantly different than mean miles per gallon of American cars (two-sample t-test t=12.62, p<0.0001).    

    Japanese cars get on average of 10.3 [95% CI (8.7, 11.9)] more miles per gallon than American cars.
