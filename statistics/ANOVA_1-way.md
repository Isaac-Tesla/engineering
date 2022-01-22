# 1-way ANOVA

One factor with at least 2 independent levels.

</br>

## Example:
Researchers want to test a new anti-anxiety medication. They split participants into three conditions (0mg, 50mg, and 100mg), then ask them to rate their anxiety level on a scale of 1-10. Are there any differences between the three conditions using alpha = 0.05?

</br>

</br>

<table>
<thead>
    <tr>
        <th>0mg</th>
        <th>50mg</th>
        <th>100mg</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>9</td>
        <td>7</td>
        <td>4</td>
    </tr>
    <tr>
        <td>8</td>
        <td>6</td>
        <td>3</td>
    </tr>
    <tr>
        <td>7</td>
        <td>6</td>
        <td>2</td>
    </tr>
    <tr>
        <td>8</td>
        <td>7</td>
        <td>3</td>
    </tr>
    <tr>
        <td>8</td>
        <td>8</td>
        <td>4</td>
    </tr>
    <tr>
        <td>9</td>
        <td>7</td>
        <td>3</td>
    </tr>
    <tr>
        <td>8</td>
        <td>6</td>
        <td>2</td>
    </tr>
</tbody>
</table>

</br>

</br>

1. Define H<sub>0</sub> and H<sub>A</sub>   

    H<sub>0</sub>; μ<sub>0mg</sub> = μ<sub>50mg</sub> = μ<sub>100mg</sub> (3 groups are equal to each other)  

    H<sub>A</sub>; Not all μ’s are equal.

</br>

2. Alpha    
 α = 0.05

</br>

3. Degrees of freedom   
    N = 21 (total values)   
    n = 7 (values per column)   
    a = (levels of factor) = 3  

    df<sub>Between</sub> = a – 1 = 3 – 1 = 2   
    df<sub>Within</sub> = N – a = 21 – 3 = 18  
    df<sub>Total</sub> = N – 1 = 21 – 1 = 20   

    ```
    Note: if “Total” ≠ “Between” + “Within” then something went wrong.  
    ```

</br>

4. State Decision Rule
To lookup the critical value, we need to different degrees of freedom (2, 18). Use F-table. (https://www.f-table.com/) “Within” across top, “Between” down column. Critical value = 3.5546  

    If F > 3.5546, reject H<sub>0</sub>

</br>

5. Calculate Test Statistic


</br>

</br>

<table>
<thead>
    <tr>
        <th></th>
        <th>SS</th>
        <th>df</th>
        <th>MS</th>
        <th>F</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>Between</td>
        <td>98.67</td>
        <td>2</td>
        <td>49.34</td>
        <td>86.56</td>
    </tr>
    <tr>
        <td>Within</td>
        <td>10.29</td>
        <td>18</td>
        <td>0.57</td>
    </tr>
    <tr>
        <td>Total</td>
        <td>108.95</td>
        <td>20</td>
    </tr>
</tbody>
</table>

</br>

</br>

SS<sub>between</sub> = (∑(∑a<sub>i</sub>)<sup>2</sup> / n ) – T<sup>2</sup>/N

0mg group: 9+8+7+8+8+9+8 = 57   

50mg group: 7+6+6+7+8+7+6 = 47  

100mg group: 4+3+2+3+4+3+2 = 21 
T = total sum = 125

</br>

SS<sub>between</sub> = (∑(∑a<sub>i</sub>)<sup>2</sup> / n ) – T<sup>2</sup>/N = 57<sup>2</sup> + 47<sup>2</sup> + 21<sup>2</sup> / 7 – 125<sup>2</sup>/21 = 98.67

</br>

SS<sub>within</sub> = ∑ Y<sup>2</sup> - ( ∑ ( ∑ a<sub>i</sub> )<sup>2</sup> / n )    

∑ Y<sup>2</sup> = 9<sup>2</sup>+8<sup>2</sup>+7<sup>2</sup>+8<sup>2</sup>+8<sup>2</sup>+9<sup>2</sup>+8<sup>2</sup>+7<sup>2</sup>+6<sup>2</sup>+6<sup>2</sup>+7<sup>2</sup>+8<sup>2</sup>+7<sup>2</sup>+6<sup>2</sup>+4<sup>2</sup>+3<sup>2</sup>+2<sup>2</sup>+3<sup>2</sup>+4<sup>2</sup>+3<sup>2</sup>+2<sup>2</sup>    

∑ Y<sup>2</sup> = 853  

SS<sub>within</sub> = 853 – ( 57<sup>2</sup> + 47<sup>2</sup> + 21<sup>2</sup> / 7 ) = 10.29

SS<sub>total</sub> = ∑ Y<sup>2</sup> – T<sup>2</sup> / N = 853 - 125<sup>2</sup> / 21 = 108.95

</br>

F = MS<sub>between</sub> / MS<sub>within</sub>

MS<sub>between</sub> = SS<sub>between</sub> / df<sub>between</sub> = 98.67 / 2 

    = 49.34
</br>

MS<sub>within</sub> = SS<sub>within</sub> / df<sub>within</sub> = 10.29 / 18 = 0.57

</br>

F = MS<sub>between</sub> / MS<sub>within</sub> = 49.34 / 0.57 = 86.56

</br>


6. Results
If F > 3.5546, reject H<sub>0</sub>
F = 86.56. Reject.  

</br>

7. Conclusion   

    The three conditions differed significantly on anxiety level, F(2,18) = 86.56, p<0.05.
