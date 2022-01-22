# 1-sample Wilcoxon / Wilcoxon signed ranks test

Conditions: 
* Assumes population has symmetric distribution   
* Ordinal and numerical data  
* Assumes random sample   
* Assumes H<sub>0</sub> median = theoretical value.  

A non-parametric test used to determine whether 2 dependent samples were selected from populations having the same distribution. Compare sample average to a theoretical value, but can’t use parametric test because its assumptions are violated. More powerful than “sign test”. Almost as strong as 1-sample t-test. Non-parametric equivalent to the 1-sample t-test as it compares the median to a theoretical value.

</br>

# Example

2 pastries reviewed by a panel. Which pastry is better?

<table>
<thead>
    <tr>
        <th>Taster</th>
        <th>Pastry 1</th>
        <th>Pastry 2</th>
        <th>Absolute Difference</th>
        <th>Sign function</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>1</td>
        <td>3</td>
        <td>2</td>
        <td>1</td>
        <td>1</td>
    </tr>
    <tr>
        <td>2</td>
        <td>4</td>
        <td>2</td>
        <td>2</td>
        <td>1</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5</td>
        <td>1</td>
        <td>4</td>
        <td>1</td>
    </tr>
    <tr>
        <td>4</td>
        <td>4</td>
        <td>4</td>
        <td>0</td>
        <td></td>
    </tr>
    <tr>
        <td>5</td>
        <td>2</td>
        <td>3</td>
        <td>1</td>
        <td>-1</td>
    </tr>
    <tr>
        <td>6</td>
        <td>2</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
    </tr>
    <tr>
        <td>7</td>
        <td>5</td>
        <td>2</td>
        <td>3</td>
        <td>1</td>
    </tr>
</tbody>
</table>

</br>


0. State hypotheses: H<sub>0</sub>: The median of the distributions are equal.  

1. Calculate absolute difference between data.

2. Order based on absolute difference

3. Rank (tied values split rank), add signed rank.

</br>

<table>
<thead>
    <tr>
        <th>Taster</th>
        <th>Pastry 1</th>
        <th>Pastry 2</th>
        <th>Absolute Difference</th>
        <th>Sign function</th>
        <th>Rank</th>
        <th>Signed Rank</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>4</td>
        <td>4</td>
        <td>4</td>
        <td>0</td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>1</td>
        <td>3</td>
        <td>2</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
    </tr>
    <tr>
        <td>5</td>
        <td>2</td>
        <td>3</td>
        <td>1</td>
        <td>-1</td>
        <td>2</td>
        <td>-2</td>
    </tr>
    <tr>
        <td>6</td>
        <td>2</td>
        <td>1</td>
        <td>1</td>
        <td>1</td>
        <td>2</td>
        <td>2</td>
    </tr>
    <tr>
        <td>2</td>
        <td>4</td>
        <td>2</td>
        <td>2</td>
        <td>1</td>
        <td>4</td>
        <td>4</td>
    </tr>
    <tr>
        <td>7</td>
        <td>5</td>
        <td>2</td>
        <td>3</td>
        <td>1</td>
        <td>5</td>
        <td>5</td>
    </tr>
    <tr>
        <td>3</td>
        <td>5</td>
        <td>1</td>
        <td>4</td>
        <td>1</td>
        <td>6</td>
        <td>6</td>
    </tr>
</tbody>
</table>

</br>


4. Sum ranks    

    Take sum of ranks where difference was positive = 2 - 2 + 2 + 4 + 5 + 6 : W = 17    

    The smaller W is, the less likely there is a difference between average scores. 

    n = total non-zero difference values = 6

</br>

5. Compare to probability table (http://socr.ucla.edu/Applets.dir/WilcoxonRankSumTable.html)

    Using Wilcoxon table, n = 6, probability W = 17, with alpha = 0.05, p-value = 1 (for 2 tails)

6. Results  

    W = 17 with alpha = 0.05, p-value = 1, we do not reject the null hypothesis.

7. Conclusion:  

    There is insufficient evidence to suggest the medians of the samples are not equal [Wilcoxon signed-rank, n = 6, W = 17, p>0.05].
