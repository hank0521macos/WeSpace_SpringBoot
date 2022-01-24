package tw.hankSideproject.WeSpace_SSH_SpringBoot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
@ServletComponentScan
public class WeSpace_SSH_SpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(WeSpace_SSH_SpringBootApplication.class, args);
	}

}
