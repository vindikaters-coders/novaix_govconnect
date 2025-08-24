package com.novaix.govconnect_server.seeder;

import com.novaix.govconnect_server.repository.DepartmentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class DepartmentSeeder implements CommandLineRunner {

    private final DepartmentRepository departmentRepository;

    @Override
    public void run(String... args) throws Exception {
        if (departmentRepository.count() == 0) {
            log.info("No departments found in database");
        } else {
            log.info("Found {} existing departments in database", departmentRepository.count());
        }
    }
}
