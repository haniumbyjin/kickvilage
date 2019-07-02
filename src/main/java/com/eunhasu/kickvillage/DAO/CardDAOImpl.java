package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.eunhasu.kickvillage.model.Card;

@Repository
public class CardDAOImpl implements CardDAO {
	@Resource
	SqlSession sql;

	@Override
	public String cardAdd(Card card) {
		try {
			sql.insert("Card.cardAdd", card);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}

	}

	@Override
	public List<Card> cardList(Card card) {

		return sql.selectList("Card.cardList",card);
	}

	@Override
	public String cardUpdate(Card card) {
		try {
			sql.update("Card.cardUpdate",card);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "databaseError";
		}
	}

	@Override
	public String cardDelete(HashMap<String, Object> map) {
		int re = sql.delete("Card.cardDelete",map);
		try {
			if (re==1) {
				return "success";
			} 
			return "noIdentity";
		}catch (Exception e){
			e.printStackTrace();
			return "databaseError";
		}
	}

}
