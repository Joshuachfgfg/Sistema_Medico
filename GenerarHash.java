import org.mindrot.jbcrypt.BCrypt;

public class GenerarHash {
    public static void main(String[] args) {
        String password = "admin123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
        System.out.println("Hash para 'admin123': " + hash);
        
        String password2 = "password123";
        String hash2 = BCrypt.hashpw(password2, BCrypt.gensalt(10));
        System.out.println("Hash para 'password123': " + hash2);
        
        // Verificar el hash del seed_data.sql
        String existingHash = "$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy";
        boolean matches = BCrypt.checkpw("password123", existingHash);
        System.out.println("El hash del seed_data.sql para 'password123' es válido: " + matches);
    }
}
