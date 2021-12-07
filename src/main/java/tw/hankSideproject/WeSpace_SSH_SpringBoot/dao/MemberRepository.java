package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import org.springframework.data.repository.CrudRepository;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;

public interface MemberRepository extends CrudRepository<Member, Integer> {
	
	public Member findByAccountAndPassword(String account, String password);
	
	public Member findByAccount(String account);
	
	public Member findByValidateCode(String validateCode);
	
	public Member findByToken(String token);
}
