import org.JUnit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class test_numbers {

    @Test
    void sum() {
            assertEquals(10, numbers.Sum(5,5));
    }
    @Test
    void multiply() {
        assertEquals(4, numbers.Multiply(2,2));
    }

}