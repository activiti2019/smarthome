package com.hp.pojo;

public class ModeRecord {
    private Integer dId;//修改的情景模式id

    private Integer uId;//用户id

    private Integer cnId;//控件id

    private Integer mId;//情景模式id

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }

    public Integer getcnId() {
        return cnId;
    }

    public void setcnId(Integer cnId) {
        this.cnId = cnId;
    }

    public Integer getmId() {
        return mId;
    }

    public void setmId(Integer mId) {
        this.mId = mId;
    }

    
	public ModeRecord(Integer uId, Integer cnId, Integer mId) {
		super();
		this.uId = uId;
		this.cnId = cnId;
		this.mId = mId;
	}

	public ModeRecord() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "ModeRecord [dId=" + dId + ", uId=" + uId + ", cnId=" + cnId + ", mId=" + mId + "]";
	}
    
}