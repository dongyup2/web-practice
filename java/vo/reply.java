package vo;

import java.security.Timestamp;

import lombok.Data;

@Data
public class reply {
	private int reply_bno;
	private String reply_content;
	private String reply_writer;
	private Timestamp reply_creadedate;
	private int bno;
}
