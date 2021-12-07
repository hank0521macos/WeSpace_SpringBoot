package tw.hankSideproject.WeSpace_SSH_SpringBoot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.controller.AjaxAPIController;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.controller.MemberBackEndController;

@EnableJpaAuditing
@SpringBootApplication
public class WeSpace_SSH_SpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(WeSpace_SSH_SpringBootApplication.class, args);
	}

}
