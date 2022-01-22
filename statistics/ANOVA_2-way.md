# 2-way ANOVA (factorial analysis) 

Two factors with at least 2 levels each, levels are independent. Like one-way ANOVA, but now we are dealing with 2 independent variables instead of 1.

</br>

## Example:

Researchers want to test a new anti-anxiety medication. They measure the anxiety of 36 participants on different dosages of the medication. 0mg, 50mg, and 100mg. Participants are also divided based on what school they are attending, which researchers hypothesise will affect anxiety levels. Anxiety is rated on a scale of 1-10, with 10 being “high anxiety” and 1 being “low anxiety”. Use alpha – 0.05 to conduct your analysis.

</br>

High School Students

<table>
<thead>
    <tr>
        <th>0 mg</th>
        <th>50 mg</th>
        <th>100 mg</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>3</td>
        <td>5</td>
        <td>7</td>
    </tr>
    <tr>
        <td>4</td>
        <td>4</td>
        <td>8</td>
    </tr>
    <tr>
        <td>5</td>
        <td>3</td>
        <td>7</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5</td>
        <td>8</td>
    </tr>
    <tr>
        <td>4</td>
        <td>5</td>
        <td>7</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5</td>
        <td>7</td>
    </tr>
</tbody>
</table>

</br>

College Students

<table>
<thead>
    <tr>
        <th>0 mg</th>
        <th>50 mg</th>
        <th>100 mg</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>1</td>
        <td>5</td>
        <td>9</td>
    </tr>
    <tr>
        <td>2</td>
        <td>4</td>
        <td>8</td>
    </tr>
    <tr>
        <td>1</td>
        <td>3</td>
        <td>9</td>
    </tr>
    <tr>
        <td>1</td>
        <td>5</td>
        <td>8</td>
    </tr>
    <tr>
        <td>1</td>
        <td>5</td>
        <td>7</td>
    </tr>
    <tr>
        <td>2</td>
        <td>4</td>
        <td>9</td>
    </tr>
</tbody>
</table>

</br>


1. Define H<sub>0</sub> and H<sub>A</sub>

    Dosage hypotheses   
    H<sub>0</sub> ; μ<sub>0mg</sub> = μ<sub>50mg</sub> = μ<sub>100mg</sub>   
    H<sub>A</sub> ; Not all μ’s are equal.

    </br>

    School hypotheses   
    
    H<sub>0</sub> ; μ<sub>highschool</sub> = μ<sub>college</sub>    
    H<sub>A</sub> ; μ<sub>highschool</sub> ≠ μ<sub>college</sub> 

    </br>

    Interaction hypotheses  
    H<sub>0</sub>; An interaction is absent.    
    H<sub>A</sub> ; An interaction is present.


    3 hypotheses = calculate 3 f-statistics.

</br>

2. Alpha ; α = 0.05

</br>

3. Degrees of freedom   
    df<sub>school(A)</sub> = a – 1 = 2 – 1 = 1  
    df<sub>dosage(B)</sub> = b – 1 = 3 – 1 = 2  
    df<sub>school x dosage (A x B)</sub> = (a-1)(b-1) = (2-1)(3-1) = 2  
    df<sub>error</sub> = N – ab = 36 – (2)(3) = 30  
    df<sub>total</sub> = N – 1 = 36 – 1 = 35

</br>

4. State Decision rule  
    
    3 hypotheses = 3 decision rules (use F-table)

    School (df<sub>school(A)</sub>, df<sub>error</sub>) : (1,30) critical value = 4.17  
    Dosage (df<sub>dosage(B)</sub>, df<sub>error</sub>) : (2,30) = 3.32 
    School x Dosage (df<sub>school x dosage (A x B)</sub>, df<sub>error</sub>) : (2,30) = 3.32  

    </br>

    [School] If F > 4.17, reject H<sub>0</sub>    
    [Dosage] If F > 3.32, reject H<sub>0</sub>  
    [Interaction] If F > 3.32, reject H<sub>0</sub>    

</br>

5. Calculate Test Statistic 

    Solve table for F.

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
        <td>School</td>
        <td>2.25</td>
        <td>1</td>
        <td>2.25 / 1 = 2.25</td>
        <td>2.25 / 0.54 = 4.17</td>
    </tr>
    <tr>
        <td>Dosage</td>
        <td>175.17</td>
        <td>2</td>
        <td>87.59</td>
        <td>87.59 / 0.54 = 162.20</td>
    </tr>
    <tr>
        <td>Interaction</td>
        <td>17.16</td>
        <td>2</td>
        <td>8.58</td>
        <td>8.58 / 0.54 = 15.89</td>
    </tr>
    <tr>
        <td>Error</td>
        <td>16.17</td>
        <td>30</td>
        <td>0.54</td>
        <td></td>
    </tr>
    <tr>
        <td>Total</td>
        <td>210.75</td>
        <td>35</td>
        <td></td>
        <td></td>
    </tr>
</tbody>
</table>

</br>

SS<sub>school</sub> = ( ∑ ( ∑ a<sub>i</sub> )<sup>2</sup> / b*n ) – T<sup>2</sub> / N   

High school sum = 3+4+5+3+4+3+5+4+3+5+5+5+7+8+7+8+7+7 = 93    

College sum = 1+2+1+1+1+2+5+4+3+5+5+4+9+8+9+8+7+9 = 84  

SS<sub>school</sub> = 932 + 842 / ( 3 )( 6 ) – 1772 / 36 = 2.25   

3 ‘b’ groups, 6 people in each condition, T is total sum ( 93 + 84 ), N = total number of participants  

</br>

SS<sub>dosage</sub> = ( ∑ ( ∑ b<sub>i</sub> )<sup>2</sup> / a * n ) – T<sup>2</sup> / N 

</br>

Split groups based on dosage:   

    0mg sum = 3+4+5+3+4+3+1+2+1+1+1+2 = 30      

    50mg sum = 5+4+3+5+5+5+5+4+3+5+5+4 = 53     

    100mg sum = 7+8+7+8+7+7+9+8+9+8+7+9 = 94    

SS<sub>dosage</sub> = 302 + 532 + 942/ ( 2 )( 6 ) – 1772 / 36 = 175.17    

</br>

SS<sub>school x dosage</sub> = ( ∑ ( ∑ a<sub>i</sub> b<sub>i</sub> )<sup>2</sup> / n )  - ( ∑ ( ∑ a<sub>i</sub>)<sup>2</sup> / b * n ) – ( ∑ ( ∑ b<sub>i</sub> )<sup>2</sup> / a * n ) + T<sup>2</sup> / N   

</br>

SS<sub>school x dosage</sub> = ( ∑ ( ∑ a<sub>i</sub> b<sub>i</sub> )<sup>2</sup> / n )  – 2.25 – 175.17 + 1772 / 36

</br>

Find sum of each cell.      

    (0mg, High school) = 3+4+5+3+4+3 = 22   

    (0mg, College) = 1+2+1+1+1+2 = 8    

    (50mg, High school) = 5+4+3+5+5+5 = 27  

    (50mg, College) = 5+4+3+5+5+4 = 26  

    (100mg, High school) = 7+8+7+8+7+7 = 44 

    (100mg, College) = 9+8+9+8+7+9 = 50 

SS<sub>school x dosage</sub> = ( ( 222 + 82 + 272 + 262 + 442 + 502 ) / ( 6 ) ) – 2.25 – 175.17 + 1772 / 36 = 17.16    

</br>

SS<sub>total</sub> = ∑ Y<sup>2</sup> – T<sup>2</sup>/N    

∑ Y<sup>2</sup> = 32+42+52+32+42+32+12+22+12+12+12+22+52+42+32+52+52+52+52+42+32+52+52+42+72 +82+72+82+72+72+92+82+92+82+72+92 = 1081

</br>

SS<sub>total</sub> = 1081 - 1772 / 36 = 210.75

</br>

SS<sub>error</sub> = SS<sub>total</sub> - SS<sub>school x dosage</sub> - SS<sub>dosage</sub> - SS<sub>school</sub> = 16.17

</br>

F = MS<sub>effect</sub> / MS<sub>error</sub>

</br>

6. Results  

    [School] If F > 4.17, reject H<sub>0</sub>  
    F = 4.166, retain H<sub>0</sub> 

    </br>

    [Dosage] If F > 3.32, reject H<sub>0</sub>      
    F = 162.20, reject H<sub>0</sub> 

    </br>

    [Interaction] If F > 3.32, reject H<sub>0</sub>     
    F = 15.89, reject H<sub>0</sub> 

</br>

7. Conclusion   

    High school students and college students did not have significantly different anxiety levels, F(1,30) = 4.166, p>0.05. 

    </br>

    There was a significant difference between the three different levels of dosage, F(2,30) = 162.20, p<0.05.  

    </br>
    An interaction effect was also present, F(2,30) = 15.59, p <0.05.
