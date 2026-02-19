create table BOARD_LIKE (
    lkeId int auto_increment primary key,
    boardId int not null,
    memNo int not null,
    unique (boardId, memNo)
    );
