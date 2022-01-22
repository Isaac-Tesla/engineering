# Pearson’s chi-square test (goodness of fit)

Used to compare observed results against what we’ve been told.

</br>

## Example:

Customers in a restaurant, does our observation base the expected % given by the owner? 

</br>

<table>
<thead>
    <tr>
        <th>Day</th>
        <th>M</th>
        <th>T</th>
        <th>W</th>
        <th>T</th>
        <th>F</th>
        <th>S</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>Expected %</td>
        <td>10</td>
        <td>10</td>
        <td>15</td>
        <td>20</td>
        <td>30</td>
        <td>15</td>
    </tr>
    <tr>
        <td>Observer customers</td>
        <td>30</td>
        <td>14</td>
        <td>34</td>
        <td>45</td>
        <td>57</td>
        <td>20</td>
    </tr>
</tbody>
</table>

</br>


1. Define H<sub>0</sub> and H<sub>A</sub>

H<sub>0</sub>; Owner’s % are correct   

H<sub>A</sub>; Owner not correct.

</br>

2. Alpha level: α = 0.05

</br>

3. State decision rule. 

ϗ<sup>2</sup> = ∑ (f<sub>observed</sub> – f<sub>expected</sub>)<sup>2</sup> / f<sub>expected</sub>

</br>

4. Calculate

</br>

<table>
<thead>
    <tr>
        <th>Day</th>
        <th>M</th>
        <th>T</th>
        <th>W</th>
        <th>T</th>
        <th>F</th>
        <th>S</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>Expected %</td>
        <td>10</td>
        <td>10</td>
        <td>15</td>
        <td>20</td>
        <td>30</td>
        <td>15</td>
    </tr>
    <tr>
        <td>EXPECTED</td>
        <td>200 * 10% = 20</td>
        <td>200 * 10% = 20</td>
        <td>200 * 15% = 30</td>
        <td>200 * 20% = 40</td>
        <td>200 * 30% = 60</td>
        <td>200 * 15% = 30</td>
    </tr>
    <tr>
        <td>Observer customers</td>
        <td>30</td>
        <td>14</td>
        <td>34</td>
        <td>45</td>
        <td>57</td>
        <td>20</td>
    </tr>
</tbody>
</table>

</br>


    Observed sum = 200

ϗ<sup>2</sup> = ( 30 – 20 )<sup>2</sup> / 20 + ( 14 – 20 )<sup>2</sup> / 20 + ( 34 – 30 )<sup>2</sup> / 30 + ( 45 – 40 )<sup>2</sup> / 40 + ( 57 – 60 )<sup>2</sup> / 60 + ( 20 – 30 )<sup>2</sup> / 30 = 11.44 

What is the probability of getting a result this extreme?   

DoF = ( 2 - 1 )( 6 - 1 ) = 5    

ϗ<sup>2</sup>-table : ϗ<sup>2</sup>-critical = 11.07

</br>

5. Results  

ϗ<sup>2</sup> = 11.44 > ϗ<sup>2</sup>-critical = 11.07, reject H<sub>0</sub>

</br>

6. Conclusion:  

It is unlikely this distribution is true, not a good fit (ϗ<sup>2</sup> = 11.44). 
