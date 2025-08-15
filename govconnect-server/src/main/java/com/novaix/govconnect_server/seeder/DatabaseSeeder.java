package com.novaix.govconnect_server.seeder;

import com.novaix.govconnect_server.common.Address;
import com.novaix.govconnect_server.dao.users_dao.UsersDao;
import com.novaix.govconnect_server.enums.Gender;
import com.novaix.govconnect_server.enums.Role;
import com.novaix.govconnect_server.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.time.LocalDate;

@Slf4j
@Configuration
@RequiredArgsConstructor
@Profile("dev")
@SuppressWarnings("unused")
public class DatabaseSeeder {

    private final BCryptPasswordEncoder encoder;
    @Bean
    CommandLineRunner initDatabase(UserRepository userRepository) {
        return args -> {
            if (userRepository.count() == 0) {
                userRepository.save(new UsersDao(null, "Amal", "Perera","0710000000","superadmin@email.com", encoder.encode("Password@123"),new Address("Colombo","Bambalapitiya","Western","No. 12 Galle Road"), LocalDate.parse("2004-09-18"), Gender.MALE,"111111111111", Role.ROLE_SUPERADMIN));
                userRepository.save(new UsersDao(null, "Saman", "kumara","0711111111","admin@email.com", encoder.encode("Password@123"),new Address("Kandy","Peradeniya","Central","45 Temple Street"), LocalDate.parse("2004-09-18"), Gender.MALE,"222222222222", Role.ROLE_ADMIN));
                userRepository.save(new UsersDao(null, "Nuwan", "Kulasekara","0712222222","user@email.com", encoder.encode("Password@123"),new Address("Galle","Unawatuna","Southern","23 Beach Road"), LocalDate.parse("2004-09-18"), Gender.FEMALE,"333333333333", Role.ROLE_USER));
                log.info("✅ Database seeded successfully!");
            } else {
                log.error("⚠️ Database already contains data. Skipping seeding.");
            }
        };
    }
}
