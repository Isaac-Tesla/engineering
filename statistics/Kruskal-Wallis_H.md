# Kruskal-Wallis H (One-way non-parametric ANOVA)   

Conditions: 

* Performed on ordinal (ranked) data.

</br>

## Example:

</br>

<table>
<thead>
    <tr>
        <th>Group 1</th>
        <th>Group 2</th>
        <th>Group 3</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>27</td>
        <td>20</td>
        <td>34</td>
    </tr>
    <tr>
        <td>2</td>
        <td>8</td>
        <td>31</td>
    </tr>
    <tr>
        <td>4</td>
        <td>14</td>
        <td>3</td>
    </tr>
    <tr>
        <td>18</td>
        <td>36</td>
        <td>23</td>
    </tr>
    <tr>
        <td>7</td>
        <td>21</td>
        <td>30</td>
    </tr>
    <tr>
        <td>9</td>
        <td>22</td>
        <td>6</td>
    </tr>
</tbody>
</table>

</br>

Is there a difference between Groups 1, 2, and 3 using alpha = 0.05?

1. Define H<sub>0</sub> and H<sub>A</sub> 

H<sub>0</sub>; No difference between treatments.   

H<sub>A</sub> ; Difference between treatments.  

</br>

2. Alpha: α = 0.05

</br>

3. Degrees of freedom   

df = k – 1 = 3 – 1 = 2  

k = number of groups

</br>

4. State decision rule  

Chi-square table (used for Kruskal-Wallis test).    

If ϗ2 is greater than 5.99, reject the null hypothesis. 

</br>

5. Calculate test statistic

</br>

<table>
<thead>
    <tr>
        <th>Original score</th>
        <th>Rank</th>
        <th>Original score</th>
        <th>Rank</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>2</td>
        <td>1</td>
        <td>20</td>
        <td>10</td>
    </tr>
    <tr>
        <td>3</td>
        <td>2</td>
        <td>21</td>
        <td>11</td>
    </tr>
    <tr>
        <td>4</td>
        <td>3</td>
        <td>22</td>
        <td>12</td>
    </tr>
    <tr>
        <td>6</td>
        <td>4</td>
        <td>23</td>
        <td>13</td>
    </tr>
    <tr>
        <td>7</td>
        <td>5</td>
        <td>27</td>
        <td>14</td>
    </tr>
    <tr>
        <td>8</td>
        <td>6</td>
        <td>30</td>
        <td>15</td>
    </tr>
    <tr>
        <td>9</td>
        <td>7</td>
        <td>31</td>
        <td>16</td>
    </tr>
    <tr>
        <td>14</td>
        <td>8</td>
        <td>34</td>
        <td>17</td>
    </tr>
    <tr>
        <td>18</td>
        <td>9</td>
        <td>36</td>
        <td>18</td>
    </tr>
</tbody>
</table>

</br>


Rebuild 1<sup>st</sup> table using ranks.

</br>

<table>
<thead>
    <tr>
        <th>Group 1</th>
        <th>Group 2</th>
        <th>Group 3</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>14</td>
        <td>10</td>
        <td>17</td>
    </tr>
    <tr>
        <td>1</td>
        <td>6</td>
        <td>16</td>
    </tr>
    <tr>
        <td>3</td>
        <td>8</td>
        <td>2</td>
    </tr>
    <tr>
        <td>9</td>
        <td>18</td>
        <td>13</td>
    </tr>
    <tr>
        <td>5</td>
        <td>11</td>
        <td>15</td>
    </tr>
    <tr>
        <td>7</td>
        <td>12</td>
        <td>4</td>
    </tr>
</tbody>
</table>

</br>


H = 12 / N ( N + 1) * ( Σ ( T<sup>2</sup><sub>i</sub> / n ) ) – 3 ( N + 1 )


</br>

<table>
<thead>
    <tr>
        <th></th>
        <th>Group 1</th>
        <th>Group 2</th>
        <th>Group 3</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td></td>
        <td>14</td>
        <td>10</td>
        <td>17</td>
    </tr>
    <tr>
        <td></td>
        <td>1</td>
        <td>6</td>
        <td>16</td>
    </tr>
    <tr>
        <td></td>
        <td>3</td>
        <td>8</td>
        <td>2</td>
    </tr>
    <tr>
        <td></td>
        <td>9</td>
        <td>18</td>
        <td>13</td>
    </tr>
    <tr>
        <td></td>
        <td>5</td>
        <td>11</td>
        <td>15</td>
    </tr>
    <tr>
        <td></td>
        <td>7</td>
        <td>12</td>
        <td>4</td>
    </tr>
    <tr>
        <td>T</td>
        <td>39</td>
        <td>65</td>
        <td>67</td>
    </tr>
    <tr>
        <td>n</td>
        <td>6</td>
        <td>6</td>
        <td>6</td>
    </tr>
</tbody>
</table>

</br>

H = 12 / N ( N + 1) * ( Σ ( T<sup>2</sup><sub>i</sub> / n ) ) – 3 ( N + 1 )

H = 12 / 18 ( 18 + 1 ) * ( 392 / 6 + 652 / 6 + 672 / 6 ) – 3 ( 18 + 1 ) = 2.854

</br>

6. State results    

If ϗ2 is greater than 5.99, reject the null hypothesis. 

H = 2.854   

Do not reject the null hypothesis.  

</br>

7. Conclusion   

There is no significant difference among the three groups, H = 2.854 (2, N=18), p>0.05.
