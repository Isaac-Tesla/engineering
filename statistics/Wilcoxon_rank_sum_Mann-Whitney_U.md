# Wilcoxon rank sum test / Mann-Whitney U test  

It is a version of the independent samples t-test performed on ordinal (ranked) data.

Conditions: 
* Random sample   
* Observations independent (within each sample)
* Two samples independent (non-paired)  
* Non-parametric test. Cannot assume normally distributed population, or variances are the same.    


## Example:

Is there a difference between treatment A and treatment B using alpha = 0.05?

</br>

<table>
<thead>
    <tr>
        <th>Treatment A</th>
        <th>Treatment B</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>28</td>
        <td>12</td>
    </tr>
    <tr>
        <td>31</td>
        <td>18</td>
    </tr>
    <tr>
        <td>36</td>
        <td>19</td>
    </tr>
    <tr>
        <td>35</td>
        <td>14</td>
    </tr>
    <tr>
        <td>32</td>
        <td>20</td>
    </tr>
    <tr>
        <td>33</td>
        <td>19</td>
    </tr>
</tbody>
</table>

</br>


1. Define H<sub>0</sub> and H<sub>A</sub>    
    
    H<sub>0</sub>; No difference between ranks 
    H<sub>A</sub>; Difference between ranks.   

</br>

2. Alpha level: α = 0.05    

</br>

3. State decision rule. 

If sample greater than 20, use Z –distribution, otherwise?  

From Z-table, area in body = 0.9750 (as it is 2 tailed, 2.5% at top is 97.5%), Z = 1.96 

If z < -1.96 OR z > 1.96 reject H<sub>0</sub>

</br>

4. Calculate test statistic 


</br>

<table>
<thead>
    <tr>
        <th>Rank</th>
        <th>Score</th>
        <th>Sample</th>
        <th>Points</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>1</td>
        <td>12</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>2</td>
        <td>14</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>3</td>
        <td>18</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>4.5</td>
        <td>19</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>4.5</td>
        <td>19</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>6</td>
        <td>20</td>
        <td>(B)</td>
        <td>6</td>
    </tr>
    <tr>
        <td>7</td>
        <td>28</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
    <tr>
        <td>8</td>
        <td>31</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
    <tr>
        <td>9</td>
        <td>32</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
    <tr>
        <td>10</td>
        <td>33</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
    <tr>
        <td>11</td>
        <td>35</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
    <tr>
        <td>12</td>
        <td>36</td>
        <td>(A)</td>
        <td>0</td>
    </tr>
</tbody>
</table>

</br>

Assign points: For every B-sample, it will get 1 point for every A-sample that is above it. For every A-sample, it will get 1 point for every B-sample above it.    

U<sub>A</sub> = 0+0+0+0+0+0 = 0 

U<sub>B</sub> = 6+6+6+6+6+6 = 36    

U = 0 (this is the smaller of the 2 values U<sub>A</sub> & U<sub>B</sub>)

Z = ( U – ( n<sub>A</sub> n<sub>B</sub> / 2 ) ) / √( n<sub>A</sub> n<sub>B</sub> ( n<sub>A</sub> + n<sub>B</sub> + 1 ) / 12 ) 

n<sub>A</sub> = 6, nB = 6, U = 0   

Z = 0 – 36 / 2  /  √ ( 36 ( 6 + 6 + 1 ) / 12 ) = -2.88  

</br>

5. State results    

    Z = -2.88 which is < -1.96. Reject H<sub>0</sub>

</br>

6. Conclusion   

There is a difference between the ranks of the two treatments, z = -2.88, p<0.05.
