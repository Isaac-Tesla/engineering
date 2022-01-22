# Mood’s median test    

Used to compare the medians for 2 samples to find out if they are different.

</br>

## Example: 

Four different methods of growing corn were randomly assigned to a large number of different plots of land and the yield per acre was computed for each plot.

</br>

<table>
<thead>
    <tr>
        <th>Method 1</th>
        <th>Method 2</th>
        <th>Method 3</th>
        <th>Method 4</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>83</td>
        <td>91</td>
        <td>101</td>
        <td>78</td>
    </tr>
    <tr>
        <td>91</td>
        <td>90</td>
        <td>100</td>
        <td>82</td>
    </tr>
    <tr>
        <td>94</td>
        <td>81</td>
        <td>91</td>
        <td>81</td>
    </tr>
    <tr>
        <td>89</td>
        <td>83</td>
        <td>93</td>
        <td>77</td>
    </tr>
    <tr>
        <td>89</td>
        <td>84</td>
        <td>96</td>
        <td>79</td>
    </tr>
    <tr>
        <td>96</td>
        <td>83</td>
        <td>95</td>
        <td>81</td>
    </tr>
    <tr>
        <td>91</td>
        <td>88</td>
        <td>94</td>
        <td>80</td>
    </tr>
    <tr>
        <td>92</td>
        <td>91</td>
        <td></td>
        <td>81</td>
    </tr>
    <tr>
        <td>90</td>
        <td>89</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td>84</td>
        <td></td>
        <td></td>
    </tr>
</tbody>
</table>

</br>

1. Define H<sub>0</sub> and H<sub>A</sub>   

H<sub>0</sub>; Medians of populations from which samples are drawn are identical    

H<sub>A</sub>; Medians of populations from which samples are drawn are NOT identical    

</br>

2. Alpha level: α = 0.05

</br>

3. Make a 2 x k contingency table, where k is the number of samples (in this case 4). Find M, the overall median for all the data in the samples. To do this list all of the data from all samples in a single set in ascending order, and then find the middle number.

</br>

Grand median, M = 89.   

</br>

<table>
<thead>
    <tr>
        <th></th>
        <th>Method 1</th>
        <th>Method 2</th>
        <th>Method 3</th>
        <th>Method 4</th>
        <th>TOTAL</th>
    </tr>
</thead>
<tbody>
    <tr>
        <td>>89</td>
        <td>6</td>
        <td>3</td>
        <td>7</td>
        <td>0</td>
        <td>16</td>
    </tr>
    <tr>
        <td>≤89</td>
        <td>3</td>
        <td>7</td>
        <td>0</td>
        <td>8</td>
        <td>18</td>
    </tr>
    <tr>
        <td>TOTAL</td>
        <td>9</td>
        <td>10</td>
        <td>7</td>
        <td>8</td>
        <td>34</td>
    </tr>
</tbody>
</table>

</br>

4. Perform a chi-square test on the completed contingency table.    

ϗ2 = ∑ (fobserved – fexpected)2 / fexpected 

Degrees of freedom = (number of rows – 1) * (number of columns – 1).    

DoF = 3 

ϗ2 = (6 – 3)2 / 9 + (3 – 7)2 / 10 + (7 – 0)2 / 7 + (0 – 8)2 / 8 = 1 + 16/10 + 7 + 8 = 17.54 

t = 17.54, 

Lookup from t-table: p-value = 0.001    

</br>

5. State results: 

    p-value = 0.001 < alpha = 0.05, we reject the null hypothesis.

</br>

6. Conclusion: 
    
    The medians of the populations from which the samples are drawn are not identical 
    
    [Mood’s median, df = 3, t = 17.54, p>0.05].
