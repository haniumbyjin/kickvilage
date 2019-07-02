package com.eunhasu.kickvillage.DAO;

import java.util.HashMap;
import java.util.List;

import com.eunhasu.kickvillage.model.Card;

public interface CardDAO {

	String cardAdd(Card card);

	List<Card> cardList(Card card);

	String cardUpdate(Card card);

	String cardDelete(HashMap<String, Object> map);

}
