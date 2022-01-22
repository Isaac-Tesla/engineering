# Paired t-test (dependent t-test, two-way ANOVA without replication)

Use the same group before and after (dependent).

## Example:
Researchers want to test a new anti-hunger weight loss pill. They have 10 people rate their hunger both before and after taking the pill. Does the pill do anything? Use alpha = 0.05

</br>

<table>
<thead>
    <tr>
        <th>Before</th>
        <th>After</th>
        <th>Difference</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>9</td>
        <td>7</td>
        <td>2</td>
    </tr>
    <tr>
        <td>10</td>
        <td>6</td>
        <td>4</td>
    </tr>
    <tr>
        <td>7</td>
        <td>5</td>
        <td>2</td>
    </tr>
    <tr>
        <td>5</td>
        <td>4</td>
        <td>1</td>
    </tr>
    <tr>
        <td>7</td>
        <td>4</td>
        <td>3</td>
    </tr>
    <tr>
        <td>5</td>
        <td>6</td>
        <td>-1</td>
    </tr>
    <tr>
        <td>9</td>
        <td>7</td>
        <td>2</td>
    </tr>
    <tr>
        <td>6</td>
        <td>5</td>
        <td>1</td>
    </tr>
    <tr>
        <td>8</td>
        <td>5</td>
        <td>3</td>
    </tr>
    <tr>
        <td>7</td>
        <td>7</td>
        <td>0</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td>ẋ<sub>D</sub> = 1.7</td>
    </tr>
</tbody>
</table>

</br>

</br>

1. Define H<sub>0</sub> and H<sub>A</sub>  

    H<sub>0</sub>; μ<sub>before</sub> = μ<sub>after</sub>    
    H<sub>A</sub> ; μ<sub>before</sub> ≠ μ<sub>after</sub>  

</br>

2. α = 0.05

</br>

3. Degrees of freedom   

    df = N - 1  
    df = (total number of people) – 1 = 10 – 1 = 9  

</br>

4. Decision rule.   
    
    From t-table (http://www.ttable.org/), t<sub>critical</sub> = 2.2622,  
    therefore if < -2.2622 or > 2.2622 reject H<sub>0</sub>   

</br>

5. Calculate test statistic 

    Equation to calculate ‘t’ in dependent samples t-test.  

    t = ẋ<sub>D</sub> / (s<sub>D</sub> / √n)

    s<sub>D</sub> = √ ( ∑x<sup>2</sup> – ( ( ∑x )<sup>2</sup> / n ) / ( n – 1 ) ) ) 
    
    = √ ( 49 – ( ( 17 )<sup>2</sup> / 10 ) / ( 10 – 1 ) ) )  
    
    = 1.49


    ẋ<sub>D</sub> = mean difference = 1.7  

    s<sub>D</sub> = standard deviation of difference = 1.49 

    n = sample size = 10

    t = ẋ<sub>D</sub> / ( s<sub>D</sub> / √n )  

    t = 1.7 / ( 1.49 / √10 ) = 3.61

</br>

6. State results    

    t = 3.61, which is > 2.2622, therefore reject H<sub>0</sub>

</br>

7. Conclusion   

    The anti-hunger weight loss pill significantly affected hunger, t = 3.61, p<0.05.
