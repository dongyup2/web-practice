package vo;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regdate;
	private Timestamp moddate;
}
