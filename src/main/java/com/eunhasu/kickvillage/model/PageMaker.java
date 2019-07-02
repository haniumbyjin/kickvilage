package com.eunhasu.kickvillage.model;

public class PageMaker {
	//블록>페이지>컨텐츠
	
	//페이지안에 있는 컨텐츠
	private Integer totalCount; 
	private Integer contentNum=10;
	
	//현재 페이지 번호
	private Integer pageNum;

	//시작, 끝 페이지, 한번에 몇개의 페이지를 보여줄지
	private Integer startPage=1;
	private Integer endPage=5;
	
	//블록
	private Integer currentBlock;
	private Integer lastBlock;
	
	//다음, 이전 페이지 이동할수 있는 값
	private boolean prev; //이전
	private boolean next; //다음
	
	//화살표 표시해주는 부분
	public void prevnext(Integer pageNum) {
		if(pageNum>0 && pageNum<6) {
			setPrev(false);
			setNext(true);
		}
		else if(getLastBlock() == getCurrentBlock()) {
			setPrev(true);
			setNext(false);
		}else {
			setPrev(true);
			setNext(true);
		}
	}


	//블럭 숫자를 구하는 계삭식
	public Integer calcPage(int totalCount, int showPage) {
		int totalPage = totalCount / showPage;
		if(totalCount%showPage > 0) {
			totalPage++;
		}
		return totalPage;
	}

	//전체 컨텐츠
	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	
	//페이지 안에있는 컨텐츠
	public Integer getContentNum() {
		return contentNum;
	}

	public void setContentNum(Integer contentNum) {
		this.contentNum = contentNum;
	}
	
	//컨텐츠 끝
	/*---------------------------------------------------------------------------------------------*/
	
	//현재 페이지 번호
	public Integer getPageNum() {
		if(pageNum == null) {
			this.pageNum = 1;
		}
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		
		this.pageNum = pageNum;
	}

	
	//시작 페이지
	public Integer getStartPage() {
		return startPage;
	}

	public void setStartPage(Integer currentBlock) {
		if(currentBlock== null) {
			this.startPage = 1;
		}
		this.startPage = (currentBlock*5)-4;
	}
	
	//끝나는 페이지
	public Integer getEndPage() {
		return endPage;
	}

	public void setEndPage(Integer getLastBlock, int getCurrentBlock) {
		if(getLastBlock == getCurrentBlock) {
			this.endPage = calcPage(getTotalCount(),getContentNum());
		}else {
			this.endPage = getStartPage()+4;	
		}
	}
	
	//페이지 끝
	/*---------------------------------------------------------------------------------------------*/
	
	
	//현재 블록
	public Integer getCurrentBlock() {
		return currentBlock;
	}


	public void setCurrentBlock(Integer pageNum) {
		this.currentBlock = pageNum/5;
		if(pageNum%5>0) {
			this.currentBlock++;
		}
	}

	//마지막 블록
	public Integer getLastBlock() {
		
		return lastBlock;
	}


	public void setLastBlock(Integer totalCount) {
		this.lastBlock = totalCount / (5*this.contentNum);
		if(totalCount%(5*this.contentNum)>0) {
			this.lastBlock++;
		}
	}

	//블록 끝
	/*---------------------------------------------------------------------------------------------*/
		
	
	
	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}

	

}
