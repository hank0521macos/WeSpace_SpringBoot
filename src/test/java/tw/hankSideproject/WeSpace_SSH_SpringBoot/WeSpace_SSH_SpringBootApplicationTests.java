package tw.hankSideproject.WeSpace_SSH_SpringBoot;

import javax.persistence.PersistenceContext;

import org.hibernate.Session;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesOwnerRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.dao.FacilitiesRepository;
import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Member;

@SpringBootTest
class WeSpace_SSH_SpringBootApplicationTests {

	@Test
	void contextLoads() {
	}
	
	@PersistenceContext
	private Session session;
	
//	@Test
//	@Transactional
//	public void testSessionFactory() {
//		List result = session.createNativeQuery("select * from MEMBER").list();
//		for(Object obj : result) {
//			Object[] array = (Object[])obj;
//			System.out.println(array[1] + "" + array[2]);
//		}
//	}
//	
//	@Autowired
//	private DataSource datasource;
//	
//	@Test
//	public void testConnection() throws SQLException{
//		Connection conn = datasource.getConnection();
//		Statement stmt = conn.createStatement();
//		ResultSet rset = stmt.executeQuery("select * from MANAGER");
//		
//		while(rset.next()) {
//			String col1 = rset.getString(1);
//			String col2 = rset.getString(2);
//			
//			System.out.println(col1 + ":" + col2);
//
//		}
//		rset.close();
//		stmt.close();
//		conn.close();
//	}
	
//	@Autowired
//    private JavaMailSender mailSender;
//
//    @Test
//    public void sendSimpleMail() throws Exception {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setFrom("hank0521macos@gmail.com");
//        message.setTo("md6000dv@gmail.com");
//        message.setSubject("主旨：Hello Wu");
//        message.setText("內容：這是一封測試信件，恭喜您成功發送了唷");
//
//        mailSender.send(message);
//    }
    
    @Autowired
    private FacilitiesRepository facilitiesRepository;
    
	@Autowired
	FacilitiesOwnerRepository facilitiesOwnerRepository;
    
    @Test
    public void deleteFacilitiesOwner() {
 
    	facilitiesOwnerRepository.deleteById(1);
    	
    	
    }
 

}
