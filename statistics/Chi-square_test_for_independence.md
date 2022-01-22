# Chi-square test for independence

Evaluates relationship between 2 variables. 
* Non-parametric test
* Performed on categorical (nominal or ordinal) data

## Example: 

Gender and colour link? 

</br>

<table>
<thead>
    <tr>
        <th></th>
        <th>Blue</th>
        <th>Green</th>
        <th>Pink</th>
        <th>Total</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>Boy</td>
        <td>100</td>
        <td>150</td>
        <td>20</td>
        <td>270</td>
    </tr>
    <tr>
        <td>Girl</td>
        <td>20</td>
        <td>30</td>
        <td>180</td>
        <td>230</td>
    </tr>
    <tr>
        <td>Total</td>
        <td>120</td>
        <td>180</td>
        <td>200</td>
        <td>n = 500</td>
    </tr>
</tbody>
</table>

</br>

1. State hypotheses.    

H<sub>0</sub>; Gender and colour are not related.   

H<sub>A</sub>; Gender and colour are related.

</br>

2. Alpha level: α = 0.05

f<sub>expected</sub> values:    

f<sub>expected</sub> = f<sub>row</sub> x f<sub>column</sub> / n

(boy, blue) = 120 x 270 / 500 = 64.8    

(girl, blue) = 120 x 230 / 500 = 55.2   

(boy, green) = 180 x 270 / 500 = 97.2   

(girl, green) = 180 x 230 / 500 = 82.8  

(boy, pink) = 200 x 270 / 500 = 108 

(girl, pink) = 200 x 230 / 500 = 92 

</br>

ϗ<sup>2</sup> = ∑ (f<sub>observed</sub> – f<sub>expected</sub>)<sup>2</sup> / f<sub>expected</sub>


ϗ<sup>2</sup> = ( 100 – 64.8 )<sup>2</sup> / 64.8 + ( 20 – 55.2 )<sup>2</sup> / 55.2 + ( 150 – 97.2 )<sup>2</sup> / 97.2 + ( 30 – 82.8 )<sup>2</sup> / 82.8 + ( 20 – 108 )<sup>2</sup> / 108 + ( 180 – 92 )<sup>2</sup> / 92  

ϗ<sup>2</sup> = 259.80  

Degrees of freedom = (row – 1)(col – 1) = 1 x 2 = 2 df  

ϗ<sup>2</sup><sub>critical</sub> = 5.99 for 2 degrees of freedom.

As ϗ<sup>2</sup> = 259.80 > ϗ<sup>2</sup><sub>critical</sub> = 5.99, we reject H<sub>0</sub>    

</br>

Conclusion:     

In the population there is a relationship between gender and colour (chi-square test for independence, ϗ<sup>2</sup> = 259.80)
