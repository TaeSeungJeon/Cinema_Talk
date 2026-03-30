package DTO.Board;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 게시글 내 URL 링크 미리보기 데이터 전달 객체 (DTO)
 * - 게시글 본문에서 URL을 추출하고 OG 메타 태그를 파싱하여 채운다
 */
@Getter
@AllArgsConstructor
public class LinkPreviewDTO {

    private String url;          // 원본 URL
    private String title;        // OG title
    private String description;  // OG description
    private String image;        // OG image URL
}
