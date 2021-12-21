package tw.hankSideproject.WeSpace_SSH_SpringBoot.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.hankSideproject.WeSpace_SSH_SpringBoot.domain.Orders;

public interface OrdersRepository extends JpaRepository<Orders,Integer> {

}
