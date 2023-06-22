package kr.book.vo;

public class BookMarkVO {
	private int mark_num; 
	private int bk_num;
	private int mem_num;
	
	//디폴트 생성자
	public BookMarkVO() {}
	
	//생성자 정의
	public BookMarkVO(int bk_num, int mem_num) {
		this.bk_num = bk_num;
		this.mem_num = mem_num;
	}

	public int getMark_num() {
		return mark_num;
	}

	public void setMark_num(int mark_num) {
		this.mark_num = mark_num;
	}

	public int getBk_num() {
		return bk_num;
	}

	public void setBk_num(int bk_num) {
		this.bk_num = bk_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
}
