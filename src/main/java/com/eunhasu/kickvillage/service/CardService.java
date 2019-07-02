package com.eunhasu.kickvillage.service;

import java.util.HashMap;
import java.util.List;

import com.eunhasu.kickvillage.model.Card;

public interface CardService {

	String cardAdd(Card card);

	List<Card> cardList(Card card);

	String cardUpdate(Card card);

	String cardDelete(HashMap<String, Object> map);

}
