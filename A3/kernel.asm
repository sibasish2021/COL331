
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 00 75 11 80       	mov    $0x80117500,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 1c 40 10 80       	mov    $0x8010401c,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 14             	sub    $0x14,%esp
8010003b:	e8 45 03 00 00       	call   80100385 <__x86.get_pc_thunk.bx>
80100040:	81 c3 80 c4 00 00    	add    $0xc480,%ebx
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100046:	83 ec 08             	sub    $0x8,%esp
80100049:	8d 83 64 cf ff ff    	lea    -0x309c(%ebx),%eax
8010004f:	50                   	push   %eax
80100050:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
80100056:	50                   	push   %eax
80100057:	e8 7a 5a 00 00       	call   80105ad6 <initlock>
8010005c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005f:	8d 83 dc 47 00 00    	lea    0x47dc(%ebx),%eax
80100065:	89 83 2c 48 00 00    	mov    %eax,0x482c(%ebx)
  bcache.head.next = &bcache.head;
8010006b:	8d 83 dc 47 00 00    	lea    0x47dc(%ebx),%eax
80100071:	89 83 30 48 00 00    	mov    %eax,0x4830(%ebx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	8d 83 14 01 00 00    	lea    0x114(%ebx),%eax
8010007d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100080:	eb 4d                	jmp    801000cf <binit+0x9b>
    b->next = bcache.head.next;
80100082:	8b 93 30 48 00 00    	mov    0x4830(%ebx),%edx
80100088:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010008b:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
8010008e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100091:	8d 93 dc 47 00 00    	lea    0x47dc(%ebx),%edx
80100097:	89 50 50             	mov    %edx,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
8010009a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009d:	8d 50 0c             	lea    0xc(%eax),%edx
801000a0:	83 ec 08             	sub    $0x8,%esp
801000a3:	8d 83 6b cf ff ff    	lea    -0x3095(%ebx),%eax
801000a9:	50                   	push   %eax
801000aa:	52                   	push   %edx
801000ab:	e8 3d 58 00 00       	call   801058ed <initsleeplock>
801000b0:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000b3:	8b 83 30 48 00 00    	mov    0x4830(%ebx),%eax
801000b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000bc:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000c2:	89 83 30 48 00 00    	mov    %eax,0x4830(%ebx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000c8:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000cf:	8d 83 dc 47 00 00    	lea    0x47dc(%ebx),%eax
801000d5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000d8:	72 a8                	jb     80100082 <binit+0x4e>
  }
}
801000da:	90                   	nop
801000db:	90                   	nop
801000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000df:	c9                   	leave  
801000e0:	c3                   	ret    

801000e1 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000e1:	55                   	push   %ebp
801000e2:	89 e5                	mov    %esp,%ebp
801000e4:	53                   	push   %ebx
801000e5:	83 ec 14             	sub    $0x14,%esp
801000e8:	e8 98 02 00 00       	call   80100385 <__x86.get_pc_thunk.bx>
801000ed:	81 c3 d3 c3 00 00    	add    $0xc3d3,%ebx
  struct buf *b;

  acquire(&bcache.lock);
801000f3:	83 ec 0c             	sub    $0xc,%esp
801000f6:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
801000fc:	50                   	push   %eax
801000fd:	e8 00 5a 00 00       	call   80105b02 <acquire>
80100102:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100105:	8b 83 30 48 00 00    	mov    0x4830(%ebx),%eax
8010010b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010010e:	eb 5a                	jmp    8010016a <bget+0x89>
    if(b->dev == dev && b->blockno == blockno){
80100110:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100113:	8b 40 04             	mov    0x4(%eax),%eax
80100116:	39 45 08             	cmp    %eax,0x8(%ebp)
80100119:	75 46                	jne    80100161 <bget+0x80>
8010011b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011e:	8b 40 08             	mov    0x8(%eax),%eax
80100121:	39 45 0c             	cmp    %eax,0xc(%ebp)
80100124:	75 3b                	jne    80100161 <bget+0x80>
      b->refcnt++;
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 4c             	mov    0x4c(%eax),%eax
8010012c:	8d 50 01             	lea    0x1(%eax),%edx
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
80100135:	83 ec 0c             	sub    $0xc,%esp
80100138:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
8010013e:	50                   	push   %eax
8010013f:	e8 39 5a 00 00       	call   80105b7d <release>
80100144:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100147:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014a:	83 c0 0c             	add    $0xc,%eax
8010014d:	83 ec 0c             	sub    $0xc,%esp
80100150:	50                   	push   %eax
80100151:	e8 e5 57 00 00       	call   8010593b <acquiresleep>
80100156:	83 c4 10             	add    $0x10,%esp
      return b;
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	e9 a6 00 00 00       	jmp    80100207 <bget+0x126>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100164:	8b 40 54             	mov    0x54(%eax),%eax
80100167:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010016a:	8d 83 dc 47 00 00    	lea    0x47dc(%ebx),%eax
80100170:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100173:	75 9b                	jne    80100110 <bget+0x2f>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100175:	8b 83 2c 48 00 00    	mov    0x482c(%ebx),%eax
8010017b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010017e:	eb 6d                	jmp    801001ed <bget+0x10c>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100183:	8b 40 4c             	mov    0x4c(%eax),%eax
80100186:	85 c0                	test   %eax,%eax
80100188:	75 5a                	jne    801001e4 <bget+0x103>
8010018a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010018d:	8b 00                	mov    (%eax),%eax
8010018f:	83 e0 04             	and    $0x4,%eax
80100192:	85 c0                	test   %eax,%eax
80100194:	75 4e                	jne    801001e4 <bget+0x103>
      b->dev = dev;
80100196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100199:	8b 55 08             	mov    0x8(%ebp),%edx
8010019c:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010019f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a2:	8b 55 0c             	mov    0xc(%ebp),%edx
801001a5:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
801001a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
801001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b4:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
801001bb:	83 ec 0c             	sub    $0xc,%esp
801001be:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
801001c4:	50                   	push   %eax
801001c5:	e8 b3 59 00 00       	call   80105b7d <release>
801001ca:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	83 c0 0c             	add    $0xc,%eax
801001d3:	83 ec 0c             	sub    $0xc,%esp
801001d6:	50                   	push   %eax
801001d7:	e8 5f 57 00 00       	call   8010593b <acquiresleep>
801001dc:	83 c4 10             	add    $0x10,%esp
      return b;
801001df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001e2:	eb 23                	jmp    80100207 <bget+0x126>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001e7:	8b 40 50             	mov    0x50(%eax),%eax
801001ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001ed:	8d 83 dc 47 00 00    	lea    0x47dc(%ebx),%eax
801001f3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801001f6:	75 88                	jne    80100180 <bget+0x9f>
    }
  }
  panic("bget: no buffers");
801001f8:	83 ec 0c             	sub    $0xc,%esp
801001fb:	8d 83 72 cf ff ff    	lea    -0x308e(%ebx),%eax
80100201:	50                   	push   %eax
80100202:	e8 6e 04 00 00       	call   80100675 <panic>
}
80100207:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010020a:	c9                   	leave  
8010020b:	c3                   	ret    

8010020c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
8010020c:	55                   	push   %ebp
8010020d:	89 e5                	mov    %esp,%ebp
8010020f:	53                   	push   %ebx
80100210:	83 ec 14             	sub    $0x14,%esp
80100213:	e8 6d 01 00 00       	call   80100385 <__x86.get_pc_thunk.bx>
80100218:	81 c3 a8 c2 00 00    	add    $0xc2a8,%ebx
  struct buf *b;

  b = bget(dev, blockno);
8010021e:	83 ec 08             	sub    $0x8,%esp
80100221:	ff 75 0c             	push   0xc(%ebp)
80100224:	ff 75 08             	push   0x8(%ebp)
80100227:	e8 b5 fe ff ff       	call   801000e1 <bget>
8010022c:	83 c4 10             	add    $0x10,%esp
8010022f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
80100232:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100235:	8b 00                	mov    (%eax),%eax
80100237:	83 e0 02             	and    $0x2,%eax
8010023a:	85 c0                	test   %eax,%eax
8010023c:	75 0e                	jne    8010024c <bread+0x40>
    iderw(b);
8010023e:	83 ec 0c             	sub    $0xc,%esp
80100241:	ff 75 f4             	push   -0xc(%ebp)
80100244:	e8 7b 2c 00 00       	call   80102ec4 <iderw>
80100249:	83 c4 10             	add    $0x10,%esp
  }
  return b;
8010024c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010024f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100252:	c9                   	leave  
80100253:	c3                   	ret    

80100254 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100254:	55                   	push   %ebp
80100255:	89 e5                	mov    %esp,%ebp
80100257:	53                   	push   %ebx
80100258:	83 ec 04             	sub    $0x4,%esp
8010025b:	e8 25 01 00 00       	call   80100385 <__x86.get_pc_thunk.bx>
80100260:	81 c3 60 c2 00 00    	add    $0xc260,%ebx
  if(!holdingsleep(&b->lock))
80100266:	8b 45 08             	mov    0x8(%ebp),%eax
80100269:	83 c0 0c             	add    $0xc,%eax
8010026c:	83 ec 0c             	sub    $0xc,%esp
8010026f:	50                   	push   %eax
80100270:	e8 96 57 00 00       	call   80105a0b <holdingsleep>
80100275:	83 c4 10             	add    $0x10,%esp
80100278:	85 c0                	test   %eax,%eax
8010027a:	75 0f                	jne    8010028b <bwrite+0x37>
    panic("bwrite");
8010027c:	83 ec 0c             	sub    $0xc,%esp
8010027f:	8d 83 83 cf ff ff    	lea    -0x307d(%ebx),%eax
80100285:	50                   	push   %eax
80100286:	e8 ea 03 00 00       	call   80100675 <panic>
  b->flags |= B_DIRTY;
8010028b:	8b 45 08             	mov    0x8(%ebp),%eax
8010028e:	8b 00                	mov    (%eax),%eax
80100290:	83 c8 04             	or     $0x4,%eax
80100293:	89 c2                	mov    %eax,%edx
80100295:	8b 45 08             	mov    0x8(%ebp),%eax
80100298:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010029a:	83 ec 0c             	sub    $0xc,%esp
8010029d:	ff 75 08             	push   0x8(%ebp)
801002a0:	e8 1f 2c 00 00       	call   80102ec4 <iderw>
801002a5:	83 c4 10             	add    $0x10,%esp
}
801002a8:	90                   	nop
801002a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801002ac:	c9                   	leave  
801002ad:	c3                   	ret    

801002ae <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801002ae:	55                   	push   %ebp
801002af:	89 e5                	mov    %esp,%ebp
801002b1:	53                   	push   %ebx
801002b2:	83 ec 04             	sub    $0x4,%esp
801002b5:	e8 cb 00 00 00       	call   80100385 <__x86.get_pc_thunk.bx>
801002ba:	81 c3 06 c2 00 00    	add    $0xc206,%ebx
  if(!holdingsleep(&b->lock))
801002c0:	8b 45 08             	mov    0x8(%ebp),%eax
801002c3:	83 c0 0c             	add    $0xc,%eax
801002c6:	83 ec 0c             	sub    $0xc,%esp
801002c9:	50                   	push   %eax
801002ca:	e8 3c 57 00 00       	call   80105a0b <holdingsleep>
801002cf:	83 c4 10             	add    $0x10,%esp
801002d2:	85 c0                	test   %eax,%eax
801002d4:	75 0f                	jne    801002e5 <brelse+0x37>
    panic("brelse");
801002d6:	83 ec 0c             	sub    $0xc,%esp
801002d9:	8d 83 8a cf ff ff    	lea    -0x3076(%ebx),%eax
801002df:	50                   	push   %eax
801002e0:	e8 90 03 00 00       	call   80100675 <panic>

  releasesleep(&b->lock);
801002e5:	8b 45 08             	mov    0x8(%ebp),%eax
801002e8:	83 c0 0c             	add    $0xc,%eax
801002eb:	83 ec 0c             	sub    $0xc,%esp
801002ee:	50                   	push   %eax
801002ef:	e8 ba 56 00 00       	call   801059ae <releasesleep>
801002f4:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
801002f7:	83 ec 0c             	sub    $0xc,%esp
801002fa:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
80100300:	50                   	push   %eax
80100301:	e8 fc 57 00 00       	call   80105b02 <acquire>
80100306:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100309:	8b 45 08             	mov    0x8(%ebp),%eax
8010030c:	8b 40 4c             	mov    0x4c(%eax),%eax
8010030f:	8d 50 ff             	lea    -0x1(%eax),%edx
80100312:	8b 45 08             	mov    0x8(%ebp),%eax
80100315:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
80100318:	8b 45 08             	mov    0x8(%ebp),%eax
8010031b:	8b 40 4c             	mov    0x4c(%eax),%eax
8010031e:	85 c0                	test   %eax,%eax
80100320:	75 4b                	jne    8010036d <brelse+0xbf>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100322:	8b 45 08             	mov    0x8(%ebp),%eax
80100325:	8b 40 54             	mov    0x54(%eax),%eax
80100328:	8b 55 08             	mov    0x8(%ebp),%edx
8010032b:	8b 52 50             	mov    0x50(%edx),%edx
8010032e:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100331:	8b 45 08             	mov    0x8(%ebp),%eax
80100334:	8b 40 50             	mov    0x50(%eax),%eax
80100337:	8b 55 08             	mov    0x8(%ebp),%edx
8010033a:	8b 52 54             	mov    0x54(%edx),%edx
8010033d:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100340:	8b 93 30 48 00 00    	mov    0x4830(%ebx),%edx
80100346:	8b 45 08             	mov    0x8(%ebp),%eax
80100349:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
8010034c:	8b 45 08             	mov    0x8(%ebp),%eax
8010034f:	8d 93 dc 47 00 00    	lea    0x47dc(%ebx),%edx
80100355:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next->prev = b;
80100358:	8b 83 30 48 00 00    	mov    0x4830(%ebx),%eax
8010035e:	8b 55 08             	mov    0x8(%ebp),%edx
80100361:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
80100364:	8b 45 08             	mov    0x8(%ebp),%eax
80100367:	89 83 30 48 00 00    	mov    %eax,0x4830(%ebx)
  }
  
  release(&bcache.lock);
8010036d:	83 ec 0c             	sub    $0xc,%esp
80100370:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
80100376:	50                   	push   %eax
80100377:	e8 01 58 00 00       	call   80105b7d <release>
8010037c:	83 c4 10             	add    $0x10,%esp
}
8010037f:	90                   	nop
80100380:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100383:	c9                   	leave  
80100384:	c3                   	ret    

80100385 <__x86.get_pc_thunk.bx>:
80100385:	8b 1c 24             	mov    (%esp),%ebx
80100388:	c3                   	ret    

80100389 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80100389:	55                   	push   %ebp
8010038a:	89 e5                	mov    %esp,%ebp
8010038c:	83 ec 14             	sub    $0x14,%esp
8010038f:	e8 94 09 00 00       	call   80100d28 <__x86.get_pc_thunk.ax>
80100394:	05 2c c1 00 00       	add    $0xc12c,%eax
80100399:	8b 45 08             	mov    0x8(%ebp),%eax
8010039c:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003a0:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801003a4:	89 c2                	mov    %eax,%edx
801003a6:	ec                   	in     (%dx),%al
801003a7:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801003aa:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801003ae:	c9                   	leave  
801003af:	c3                   	ret    

801003b0 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801003b0:	55                   	push   %ebp
801003b1:	89 e5                	mov    %esp,%ebp
801003b3:	83 ec 08             	sub    $0x8,%esp
801003b6:	e8 6d 09 00 00       	call   80100d28 <__x86.get_pc_thunk.ax>
801003bb:	05 05 c1 00 00       	add    $0xc105,%eax
801003c0:	8b 45 08             	mov    0x8(%ebp),%eax
801003c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801003c6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801003ca:	89 d0                	mov    %edx,%eax
801003cc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003cf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801003d3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801003d7:	ee                   	out    %al,(%dx)
}
801003d8:	90                   	nop
801003d9:	c9                   	leave  
801003da:	c3                   	ret    

801003db <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801003db:	55                   	push   %ebp
801003dc:	89 e5                	mov    %esp,%ebp
801003de:	e8 45 09 00 00       	call   80100d28 <__x86.get_pc_thunk.ax>
801003e3:	05 dd c0 00 00       	add    $0xc0dd,%eax
  asm volatile("cli");
801003e8:	fa                   	cli    
}
801003e9:	90                   	nop
801003ea:	5d                   	pop    %ebp
801003eb:	c3                   	ret    

801003ec <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801003ec:	55                   	push   %ebp
801003ed:	89 e5                	mov    %esp,%ebp
801003ef:	53                   	push   %ebx
801003f0:	83 ec 24             	sub    $0x24,%esp
801003f3:	e8 34 09 00 00       	call   80100d2c <__x86.get_pc_thunk.cx>
801003f8:	81 c1 c8 c0 00 00    	add    $0xc0c8,%ecx
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801003fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100402:	74 1c                	je     80100420 <printint+0x34>
80100404:	8b 45 08             	mov    0x8(%ebp),%eax
80100407:	c1 e8 1f             	shr    $0x1f,%eax
8010040a:	0f b6 c0             	movzbl %al,%eax
8010040d:	89 45 10             	mov    %eax,0x10(%ebp)
80100410:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100414:	74 0a                	je     80100420 <printint+0x34>
    x = -xx;
80100416:	8b 45 08             	mov    0x8(%ebp),%eax
80100419:	f7 d8                	neg    %eax
8010041b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010041e:	eb 06                	jmp    80100426 <printint+0x3a>
  else
    x = xx;
80100420:	8b 45 08             	mov    0x8(%ebp),%eax
80100423:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100426:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010042d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100430:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100433:	ba 00 00 00 00       	mov    $0x0,%edx
80100438:	f7 f3                	div    %ebx
8010043a:	89 d3                	mov    %edx,%ebx
8010043c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010043f:	8d 50 01             	lea    0x1(%eax),%edx
80100442:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100445:	0f b6 94 19 44 db ff 	movzbl -0x24bc(%ecx,%ebx,1),%edx
8010044c:	ff 
8010044d:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
80100451:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100454:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100457:	ba 00 00 00 00       	mov    $0x0,%edx
8010045c:	f7 f3                	div    %ebx
8010045e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100461:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100465:	75 c6                	jne    8010042d <printint+0x41>

  if(sign)
80100467:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010046b:	74 2a                	je     80100497 <printint+0xab>
    buf[i++] = '-';
8010046d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100470:	8d 50 01             	lea    0x1(%eax),%edx
80100473:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100476:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010047b:	eb 1a                	jmp    80100497 <printint+0xab>
    consputc(buf[i]);
8010047d:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100483:	01 d0                	add    %edx,%eax
80100485:	0f b6 00             	movzbl (%eax),%eax
80100488:	0f be c0             	movsbl %al,%eax
8010048b:	83 ec 0c             	sub    $0xc,%esp
8010048e:	50                   	push   %eax
8010048f:	e8 38 04 00 00       	call   801008cc <consputc>
80100494:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
80100497:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010049b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010049f:	79 dc                	jns    8010047d <printint+0x91>
}
801004a1:	90                   	nop
801004a2:	90                   	nop
801004a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004a6:	c9                   	leave  
801004a7:	c3                   	ret    

801004a8 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801004a8:	55                   	push   %ebp
801004a9:	89 e5                	mov    %esp,%ebp
801004ab:	53                   	push   %ebx
801004ac:	83 ec 24             	sub    $0x24,%esp
801004af:	e8 d1 fe ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801004b4:	81 c3 0c c0 00 00    	add    $0xc00c,%ebx
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801004ba:	8b 83 14 4b 00 00    	mov    0x4b14(%ebx),%eax
801004c0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801004c3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801004c7:	74 12                	je     801004db <cprintf+0x33>
    acquire(&cons.lock);
801004c9:	83 ec 0c             	sub    $0xc,%esp
801004cc:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
801004d2:	50                   	push   %eax
801004d3:	e8 2a 56 00 00       	call   80105b02 <acquire>
801004d8:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801004db:	8b 45 08             	mov    0x8(%ebp),%eax
801004de:	85 c0                	test   %eax,%eax
801004e0:	75 0f                	jne    801004f1 <cprintf+0x49>
    panic("null fmt");
801004e2:	83 ec 0c             	sub    $0xc,%esp
801004e5:	8d 83 91 cf ff ff    	lea    -0x306f(%ebx),%eax
801004eb:	50                   	push   %eax
801004ec:	e8 84 01 00 00       	call   80100675 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801004f1:	8d 45 0c             	lea    0xc(%ebp),%eax
801004f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801004f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801004fe:	e9 31 01 00 00       	jmp    80100634 <cprintf+0x18c>
    if(c != '%'){
80100503:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100507:	74 13                	je     8010051c <cprintf+0x74>
      consputc(c);
80100509:	83 ec 0c             	sub    $0xc,%esp
8010050c:	ff 75 e4             	push   -0x1c(%ebp)
8010050f:	e8 b8 03 00 00       	call   801008cc <consputc>
80100514:	83 c4 10             	add    $0x10,%esp
      continue;
80100517:	e9 14 01 00 00       	jmp    80100630 <cprintf+0x188>
    }
    c = fmt[++i] & 0xff;
8010051c:	8b 55 08             	mov    0x8(%ebp),%edx
8010051f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100523:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100526:	01 d0                	add    %edx,%eax
80100528:	0f b6 00             	movzbl (%eax),%eax
8010052b:	0f be c0             	movsbl %al,%eax
8010052e:	25 ff 00 00 00       	and    $0xff,%eax
80100533:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100536:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010053a:	0f 84 16 01 00 00    	je     80100656 <cprintf+0x1ae>
      break;
    switch(c){
80100540:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100544:	74 5e                	je     801005a4 <cprintf+0xfc>
80100546:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
8010054a:	0f 8f c4 00 00 00    	jg     80100614 <cprintf+0x16c>
80100550:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
80100554:	74 6b                	je     801005c1 <cprintf+0x119>
80100556:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
8010055a:	0f 8f b4 00 00 00    	jg     80100614 <cprintf+0x16c>
80100560:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
80100564:	74 3e                	je     801005a4 <cprintf+0xfc>
80100566:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
8010056a:	0f 8f a4 00 00 00    	jg     80100614 <cprintf+0x16c>
80100570:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100574:	0f 84 8b 00 00 00    	je     80100605 <cprintf+0x15d>
8010057a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
8010057e:	0f 85 90 00 00 00    	jne    80100614 <cprintf+0x16c>
    case 'd':
      printint(*argp++, 10, 1);
80100584:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100587:	8d 50 04             	lea    0x4(%eax),%edx
8010058a:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010058d:	8b 00                	mov    (%eax),%eax
8010058f:	83 ec 04             	sub    $0x4,%esp
80100592:	6a 01                	push   $0x1
80100594:	6a 0a                	push   $0xa
80100596:	50                   	push   %eax
80100597:	e8 50 fe ff ff       	call   801003ec <printint>
8010059c:	83 c4 10             	add    $0x10,%esp
      break;
8010059f:	e9 8c 00 00 00       	jmp    80100630 <cprintf+0x188>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801005a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801005a7:	8d 50 04             	lea    0x4(%eax),%edx
801005aa:	89 55 f0             	mov    %edx,-0x10(%ebp)
801005ad:	8b 00                	mov    (%eax),%eax
801005af:	83 ec 04             	sub    $0x4,%esp
801005b2:	6a 00                	push   $0x0
801005b4:	6a 10                	push   $0x10
801005b6:	50                   	push   %eax
801005b7:	e8 30 fe ff ff       	call   801003ec <printint>
801005bc:	83 c4 10             	add    $0x10,%esp
      break;
801005bf:	eb 6f                	jmp    80100630 <cprintf+0x188>
    case 's':
      if((s = (char*)*argp++) == 0)
801005c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801005c4:	8d 50 04             	lea    0x4(%eax),%edx
801005c7:	89 55 f0             	mov    %edx,-0x10(%ebp)
801005ca:	8b 00                	mov    (%eax),%eax
801005cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
801005cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801005d3:	75 24                	jne    801005f9 <cprintf+0x151>
        s = "(null)";
801005d5:	8d 83 9a cf ff ff    	lea    -0x3066(%ebx),%eax
801005db:	89 45 ec             	mov    %eax,-0x14(%ebp)
      for(; *s; s++)
801005de:	eb 19                	jmp    801005f9 <cprintf+0x151>
        consputc(*s);
801005e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801005e3:	0f b6 00             	movzbl (%eax),%eax
801005e6:	0f be c0             	movsbl %al,%eax
801005e9:	83 ec 0c             	sub    $0xc,%esp
801005ec:	50                   	push   %eax
801005ed:	e8 da 02 00 00       	call   801008cc <consputc>
801005f2:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
801005f5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801005f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801005fc:	0f b6 00             	movzbl (%eax),%eax
801005ff:	84 c0                	test   %al,%al
80100601:	75 dd                	jne    801005e0 <cprintf+0x138>
      break;
80100603:	eb 2b                	jmp    80100630 <cprintf+0x188>
    case '%':
      consputc('%');
80100605:	83 ec 0c             	sub    $0xc,%esp
80100608:	6a 25                	push   $0x25
8010060a:	e8 bd 02 00 00       	call   801008cc <consputc>
8010060f:	83 c4 10             	add    $0x10,%esp
      break;
80100612:	eb 1c                	jmp    80100630 <cprintf+0x188>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100614:	83 ec 0c             	sub    $0xc,%esp
80100617:	6a 25                	push   $0x25
80100619:	e8 ae 02 00 00       	call   801008cc <consputc>
8010061e:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100621:	83 ec 0c             	sub    $0xc,%esp
80100624:	ff 75 e4             	push   -0x1c(%ebp)
80100627:	e8 a0 02 00 00       	call   801008cc <consputc>
8010062c:	83 c4 10             	add    $0x10,%esp
      break;
8010062f:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100630:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100634:	8b 55 08             	mov    0x8(%ebp),%edx
80100637:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010063a:	01 d0                	add    %edx,%eax
8010063c:	0f b6 00             	movzbl (%eax),%eax
8010063f:	0f be c0             	movsbl %al,%eax
80100642:	25 ff 00 00 00       	and    $0xff,%eax
80100647:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010064a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010064e:	0f 85 af fe ff ff    	jne    80100503 <cprintf+0x5b>
80100654:	eb 01                	jmp    80100657 <cprintf+0x1af>
      break;
80100656:	90                   	nop
    }
  }

  if(locking)
80100657:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010065b:	74 12                	je     8010066f <cprintf+0x1c7>
    release(&cons.lock);
8010065d:	83 ec 0c             	sub    $0xc,%esp
80100660:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100666:	50                   	push   %eax
80100667:	e8 11 55 00 00       	call   80105b7d <release>
8010066c:	83 c4 10             	add    $0x10,%esp
}
8010066f:	90                   	nop
80100670:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100673:	c9                   	leave  
80100674:	c3                   	ret    

80100675 <panic>:

void
panic(char *s)
{
80100675:	55                   	push   %ebp
80100676:	89 e5                	mov    %esp,%ebp
80100678:	53                   	push   %ebx
80100679:	83 ec 34             	sub    $0x34,%esp
8010067c:	e8 04 fd ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100681:	81 c3 3f be 00 00    	add    $0xbe3f,%ebx
  int i;
  uint pcs[10];

  cli();
80100687:	e8 4f fd ff ff       	call   801003db <cli>
  cons.locking = 0;
8010068c:	c7 83 14 4b 00 00 00 	movl   $0x0,0x4b14(%ebx)
80100693:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100696:	e8 e2 2f 00 00       	call   8010367d <lapicid>
8010069b:	83 ec 08             	sub    $0x8,%esp
8010069e:	50                   	push   %eax
8010069f:	8d 83 a1 cf ff ff    	lea    -0x305f(%ebx),%eax
801006a5:	50                   	push   %eax
801006a6:	e8 fd fd ff ff       	call   801004a8 <cprintf>
801006ab:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801006ae:	8b 45 08             	mov    0x8(%ebp),%eax
801006b1:	83 ec 0c             	sub    $0xc,%esp
801006b4:	50                   	push   %eax
801006b5:	e8 ee fd ff ff       	call   801004a8 <cprintf>
801006ba:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801006bd:	83 ec 0c             	sub    $0xc,%esp
801006c0:	8d 83 b5 cf ff ff    	lea    -0x304b(%ebx),%eax
801006c6:	50                   	push   %eax
801006c7:	e8 dc fd ff ff       	call   801004a8 <cprintf>
801006cc:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801006cf:	83 ec 08             	sub    $0x8,%esp
801006d2:	8d 45 cc             	lea    -0x34(%ebp),%eax
801006d5:	50                   	push   %eax
801006d6:	8d 45 08             	lea    0x8(%ebp),%eax
801006d9:	50                   	push   %eax
801006da:	e8 01 55 00 00       	call   80105be0 <getcallerpcs>
801006df:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801006e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801006e9:	eb 1e                	jmp    80100709 <panic+0x94>
    cprintf(" %p", pcs[i]);
801006eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006ee:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801006f2:	83 ec 08             	sub    $0x8,%esp
801006f5:	50                   	push   %eax
801006f6:	8d 83 b7 cf ff ff    	lea    -0x3049(%ebx),%eax
801006fc:	50                   	push   %eax
801006fd:	e8 a6 fd ff ff       	call   801004a8 <cprintf>
80100702:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100705:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100709:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010070d:	7e dc                	jle    801006eb <panic+0x76>
  panicked = 1; // freeze other CPU
8010070f:	c7 83 cc 4a 00 00 01 	movl   $0x1,0x4acc(%ebx)
80100716:	00 00 00 
  for(;;)
80100719:	eb fe                	jmp    80100719 <panic+0xa4>

8010071b <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
8010071b:	55                   	push   %ebp
8010071c:	89 e5                	mov    %esp,%ebp
8010071e:	56                   	push   %esi
8010071f:	53                   	push   %ebx
80100720:	83 ec 10             	sub    $0x10,%esp
80100723:	e8 5d fc ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100728:	81 c3 98 bd 00 00    	add    $0xbd98,%ebx
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
8010072e:	6a 0e                	push   $0xe
80100730:	68 d4 03 00 00       	push   $0x3d4
80100735:	e8 76 fc ff ff       	call   801003b0 <outb>
8010073a:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
8010073d:	68 d5 03 00 00       	push   $0x3d5
80100742:	e8 42 fc ff ff       	call   80100389 <inb>
80100747:	83 c4 04             	add    $0x4,%esp
8010074a:	0f b6 c0             	movzbl %al,%eax
8010074d:	c1 e0 08             	shl    $0x8,%eax
80100750:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100753:	6a 0f                	push   $0xf
80100755:	68 d4 03 00 00       	push   $0x3d4
8010075a:	e8 51 fc ff ff       	call   801003b0 <outb>
8010075f:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100762:	68 d5 03 00 00       	push   $0x3d5
80100767:	e8 1d fc ff ff       	call   80100389 <inb>
8010076c:	83 c4 04             	add    $0x4,%esp
8010076f:	0f b6 c0             	movzbl %al,%eax
80100772:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100775:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100779:	75 34                	jne    801007af <cgaputc+0x94>
    pos += 80 - pos%80;
8010077b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010077e:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100783:	89 c8                	mov    %ecx,%eax
80100785:	f7 ea                	imul   %edx
80100787:	89 d0                	mov    %edx,%eax
80100789:	c1 f8 05             	sar    $0x5,%eax
8010078c:	89 ce                	mov    %ecx,%esi
8010078e:	c1 fe 1f             	sar    $0x1f,%esi
80100791:	29 f0                	sub    %esi,%eax
80100793:	89 c2                	mov    %eax,%edx
80100795:	89 d0                	mov    %edx,%eax
80100797:	c1 e0 02             	shl    $0x2,%eax
8010079a:	01 d0                	add    %edx,%eax
8010079c:	c1 e0 04             	shl    $0x4,%eax
8010079f:	29 c1                	sub    %eax,%ecx
801007a1:	89 ca                	mov    %ecx,%edx
801007a3:	b8 50 00 00 00       	mov    $0x50,%eax
801007a8:	29 d0                	sub    %edx,%eax
801007aa:	01 45 f4             	add    %eax,-0xc(%ebp)
801007ad:	eb 38                	jmp    801007e7 <cgaputc+0xcc>
  else if(c == BACKSPACE){
801007af:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007b6:	75 0c                	jne    801007c4 <cgaputc+0xa9>
    if(pos > 0) --pos;
801007b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801007bc:	7e 29                	jle    801007e7 <cgaputc+0xcc>
801007be:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801007c2:	eb 23                	jmp    801007e7 <cgaputc+0xcc>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801007c4:	8b 45 08             	mov    0x8(%ebp),%eax
801007c7:	0f b6 c0             	movzbl %al,%eax
801007ca:	80 cc 07             	or     $0x7,%ah
801007cd:	89 c1                	mov    %eax,%ecx
801007cf:	8b b3 40 db ff ff    	mov    -0x24c0(%ebx),%esi
801007d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007d8:	8d 50 01             	lea    0x1(%eax),%edx
801007db:	89 55 f4             	mov    %edx,-0xc(%ebp)
801007de:	01 c0                	add    %eax,%eax
801007e0:	01 f0                	add    %esi,%eax
801007e2:	89 ca                	mov    %ecx,%edx
801007e4:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
801007e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801007eb:	78 09                	js     801007f6 <cgaputc+0xdb>
801007ed:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801007f4:	7e 0f                	jle    80100805 <cgaputc+0xea>
    panic("pos under/overflow");
801007f6:	83 ec 0c             	sub    $0xc,%esp
801007f9:	8d 83 bb cf ff ff    	lea    -0x3045(%ebx),%eax
801007ff:	50                   	push   %eax
80100800:	e8 70 fe ff ff       	call   80100675 <panic>

  if((pos/80) >= 24){  // Scroll up.
80100805:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
8010080c:	7e 4f                	jle    8010085d <cgaputc+0x142>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010080e:	8b 83 40 db ff ff    	mov    -0x24c0(%ebx),%eax
80100814:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010081a:	8b 83 40 db ff ff    	mov    -0x24c0(%ebx),%eax
80100820:	83 ec 04             	sub    $0x4,%esp
80100823:	68 60 0e 00 00       	push   $0xe60
80100828:	52                   	push   %edx
80100829:	50                   	push   %eax
8010082a:	e8 98 56 00 00       	call   80105ec7 <memmove>
8010082f:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100832:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100836:	b8 80 07 00 00       	mov    $0x780,%eax
8010083b:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010083e:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100841:	8b 8b 40 db ff ff    	mov    -0x24c0(%ebx),%ecx
80100847:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010084a:	01 c0                	add    %eax,%eax
8010084c:	01 c8                	add    %ecx,%eax
8010084e:	83 ec 04             	sub    $0x4,%esp
80100851:	52                   	push   %edx
80100852:	6a 00                	push   $0x0
80100854:	50                   	push   %eax
80100855:	e8 9a 55 00 00       	call   80105df4 <memset>
8010085a:	83 c4 10             	add    $0x10,%esp
  }

  outb(CRTPORT, 14);
8010085d:	83 ec 08             	sub    $0x8,%esp
80100860:	6a 0e                	push   $0xe
80100862:	68 d4 03 00 00       	push   $0x3d4
80100867:	e8 44 fb ff ff       	call   801003b0 <outb>
8010086c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010086f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100872:	c1 f8 08             	sar    $0x8,%eax
80100875:	0f b6 c0             	movzbl %al,%eax
80100878:	83 ec 08             	sub    $0x8,%esp
8010087b:	50                   	push   %eax
8010087c:	68 d5 03 00 00       	push   $0x3d5
80100881:	e8 2a fb ff ff       	call   801003b0 <outb>
80100886:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100889:	83 ec 08             	sub    $0x8,%esp
8010088c:	6a 0f                	push   $0xf
8010088e:	68 d4 03 00 00       	push   $0x3d4
80100893:	e8 18 fb ff ff       	call   801003b0 <outb>
80100898:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
8010089b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010089e:	0f b6 c0             	movzbl %al,%eax
801008a1:	83 ec 08             	sub    $0x8,%esp
801008a4:	50                   	push   %eax
801008a5:	68 d5 03 00 00       	push   $0x3d5
801008aa:	e8 01 fb ff ff       	call   801003b0 <outb>
801008af:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801008b2:	8b 93 40 db ff ff    	mov    -0x24c0(%ebx),%edx
801008b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008bb:	01 c0                	add    %eax,%eax
801008bd:	01 d0                	add    %edx,%eax
801008bf:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801008c4:	90                   	nop
801008c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801008c8:	5b                   	pop    %ebx
801008c9:	5e                   	pop    %esi
801008ca:	5d                   	pop    %ebp
801008cb:	c3                   	ret    

801008cc <consputc>:

void
consputc(int c)
{
801008cc:	55                   	push   %ebp
801008cd:	89 e5                	mov    %esp,%ebp
801008cf:	53                   	push   %ebx
801008d0:	83 ec 04             	sub    $0x4,%esp
801008d3:	e8 ad fa ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801008d8:	81 c3 e8 bb 00 00    	add    $0xbbe8,%ebx
  if(panicked){
801008de:	8b 83 cc 4a 00 00    	mov    0x4acc(%ebx),%eax
801008e4:	85 c0                	test   %eax,%eax
801008e6:	74 07                	je     801008ef <consputc+0x23>
    cli();
801008e8:	e8 ee fa ff ff       	call   801003db <cli>
    for(;;)
801008ed:	eb fe                	jmp    801008ed <consputc+0x21>
      ;
  }

  if(c == BACKSPACE){
801008ef:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801008f6:	75 29                	jne    80100921 <consputc+0x55>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801008f8:	83 ec 0c             	sub    $0xc,%esp
801008fb:	6a 08                	push   $0x8
801008fd:	e8 d4 70 00 00       	call   801079d6 <uartputc>
80100902:	83 c4 10             	add    $0x10,%esp
80100905:	83 ec 0c             	sub    $0xc,%esp
80100908:	6a 20                	push   $0x20
8010090a:	e8 c7 70 00 00       	call   801079d6 <uartputc>
8010090f:	83 c4 10             	add    $0x10,%esp
80100912:	83 ec 0c             	sub    $0xc,%esp
80100915:	6a 08                	push   $0x8
80100917:	e8 ba 70 00 00       	call   801079d6 <uartputc>
8010091c:	83 c4 10             	add    $0x10,%esp
8010091f:	eb 0e                	jmp    8010092f <consputc+0x63>
  } else
    uartputc(c);
80100921:	83 ec 0c             	sub    $0xc,%esp
80100924:	ff 75 08             	push   0x8(%ebp)
80100927:	e8 aa 70 00 00       	call   801079d6 <uartputc>
8010092c:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
8010092f:	83 ec 0c             	sub    $0xc,%esp
80100932:	ff 75 08             	push   0x8(%ebp)
80100935:	e8 e1 fd ff ff       	call   8010071b <cgaputc>
8010093a:	83 c4 10             	add    $0x10,%esp
}
8010093d:	90                   	nop
8010093e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100941:	c9                   	leave  
80100942:	c3                   	ret    

80100943 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100943:	55                   	push   %ebp
80100944:	89 e5                	mov    %esp,%ebp
80100946:	53                   	push   %ebx
80100947:	83 ec 14             	sub    $0x14,%esp
8010094a:	e8 36 fa ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010094f:	81 c3 71 bb 00 00    	add    $0xbb71,%ebx
  int c, doprocdump = 0;
80100955:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
8010095c:	83 ec 0c             	sub    $0xc,%esp
8010095f:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100965:	50                   	push   %eax
80100966:	e8 97 51 00 00       	call   80105b02 <acquire>
8010096b:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
8010096e:	e9 60 01 00 00       	jmp    80100ad3 <consoleintr+0x190>
    switch(c){
80100973:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
80100977:	0f 84 86 00 00 00    	je     80100a03 <consoleintr+0xc0>
8010097d:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
80100981:	0f 8f b4 00 00 00    	jg     80100a3b <consoleintr+0xf8>
80100987:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
8010098b:	74 45                	je     801009d2 <consoleintr+0x8f>
8010098d:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
80100991:	0f 8f a4 00 00 00    	jg     80100a3b <consoleintr+0xf8>
80100997:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
8010099b:	74 66                	je     80100a03 <consoleintr+0xc0>
8010099d:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
801009a1:	0f 85 94 00 00 00    	jne    80100a3b <consoleintr+0xf8>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801009a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801009ae:	e9 20 01 00 00       	jmp    80100ad3 <consoleintr+0x190>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801009b3:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
801009b9:	83 e8 01             	sub    $0x1,%eax
801009bc:	89 83 c8 4a 00 00    	mov    %eax,0x4ac8(%ebx)
        consputc(BACKSPACE);
801009c2:	83 ec 0c             	sub    $0xc,%esp
801009c5:	68 00 01 00 00       	push   $0x100
801009ca:	e8 fd fe ff ff       	call   801008cc <consputc>
801009cf:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801009d2:	8b 93 c8 4a 00 00    	mov    0x4ac8(%ebx),%edx
801009d8:	8b 83 c4 4a 00 00    	mov    0x4ac4(%ebx),%eax
801009de:	39 c2                	cmp    %eax,%edx
801009e0:	0f 84 ed 00 00 00    	je     80100ad3 <consoleintr+0x190>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801009e6:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
801009ec:	83 e8 01             	sub    $0x1,%eax
801009ef:	83 e0 7f             	and    $0x7f,%eax
801009f2:	0f b6 84 03 40 4a 00 	movzbl 0x4a40(%ebx,%eax,1),%eax
801009f9:	00 
      while(input.e != input.w &&
801009fa:	3c 0a                	cmp    $0xa,%al
801009fc:	75 b5                	jne    801009b3 <consoleintr+0x70>
      }
      break;
801009fe:	e9 d0 00 00 00       	jmp    80100ad3 <consoleintr+0x190>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100a03:	8b 93 c8 4a 00 00    	mov    0x4ac8(%ebx),%edx
80100a09:	8b 83 c4 4a 00 00    	mov    0x4ac4(%ebx),%eax
80100a0f:	39 c2                	cmp    %eax,%edx
80100a11:	0f 84 bc 00 00 00    	je     80100ad3 <consoleintr+0x190>
        input.e--;
80100a17:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
80100a1d:	83 e8 01             	sub    $0x1,%eax
80100a20:	89 83 c8 4a 00 00    	mov    %eax,0x4ac8(%ebx)
        consputc(BACKSPACE);
80100a26:	83 ec 0c             	sub    $0xc,%esp
80100a29:	68 00 01 00 00       	push   $0x100
80100a2e:	e8 99 fe ff ff       	call   801008cc <consputc>
80100a33:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100a36:	e9 98 00 00 00       	jmp    80100ad3 <consoleintr+0x190>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100a3f:	0f 84 8d 00 00 00    	je     80100ad2 <consoleintr+0x18f>
80100a45:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
80100a4b:	8b 93 c0 4a 00 00    	mov    0x4ac0(%ebx),%edx
80100a51:	29 d0                	sub    %edx,%eax
80100a53:	83 f8 7f             	cmp    $0x7f,%eax
80100a56:	77 7a                	ja     80100ad2 <consoleintr+0x18f>
        c = (c == '\r') ? '\n' : c;
80100a58:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100a5c:	74 05                	je     80100a63 <consoleintr+0x120>
80100a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100a61:	eb 05                	jmp    80100a68 <consoleintr+0x125>
80100a63:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100a6b:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
80100a71:	8d 50 01             	lea    0x1(%eax),%edx
80100a74:	89 93 c8 4a 00 00    	mov    %edx,0x4ac8(%ebx)
80100a7a:	83 e0 7f             	and    $0x7f,%eax
80100a7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a80:	88 94 03 40 4a 00 00 	mov    %dl,0x4a40(%ebx,%eax,1)
        consputc(c);
80100a87:	83 ec 0c             	sub    $0xc,%esp
80100a8a:	ff 75 f0             	push   -0x10(%ebp)
80100a8d:	e8 3a fe ff ff       	call   801008cc <consputc>
80100a92:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a95:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a99:	74 19                	je     80100ab4 <consoleintr+0x171>
80100a9b:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a9f:	74 13                	je     80100ab4 <consoleintr+0x171>
80100aa1:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
80100aa7:	8b 93 c0 4a 00 00    	mov    0x4ac0(%ebx),%edx
80100aad:	83 ea 80             	sub    $0xffffff80,%edx
80100ab0:	39 d0                	cmp    %edx,%eax
80100ab2:	75 1e                	jne    80100ad2 <consoleintr+0x18f>
          input.w = input.e;
80100ab4:	8b 83 c8 4a 00 00    	mov    0x4ac8(%ebx),%eax
80100aba:	89 83 c4 4a 00 00    	mov    %eax,0x4ac4(%ebx)
          wakeup(&input.r);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	8d 83 c0 4a 00 00    	lea    0x4ac0(%ebx),%eax
80100ac9:	50                   	push   %eax
80100aca:	e8 7d 4b 00 00       	call   8010564c <wakeup>
80100acf:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100ad2:	90                   	nop
  while((c = getc()) >= 0){
80100ad3:	8b 45 08             	mov    0x8(%ebp),%eax
80100ad6:	ff d0                	call   *%eax
80100ad8:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100adb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100adf:	0f 89 8e fe ff ff    	jns    80100973 <consoleintr+0x30>
    }
  }
  release(&cons.lock);
80100ae5:	83 ec 0c             	sub    $0xc,%esp
80100ae8:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100aee:	50                   	push   %eax
80100aef:	e8 89 50 00 00       	call   80105b7d <release>
80100af4:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100af7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100afb:	74 05                	je     80100b02 <consoleintr+0x1bf>
    procdump();  // now call procdump() wo. cons.lock held
80100afd:	e8 31 4c 00 00       	call   80105733 <procdump>
  }
}
80100b02:	90                   	nop
80100b03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100b06:	c9                   	leave  
80100b07:	c3                   	ret    

80100b08 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100b08:	55                   	push   %ebp
80100b09:	89 e5                	mov    %esp,%ebp
80100b0b:	53                   	push   %ebx
80100b0c:	83 ec 14             	sub    $0x14,%esp
80100b0f:	e8 71 f8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100b14:	81 c3 ac b9 00 00    	add    $0xb9ac,%ebx
  uint target;
  int c;

  iunlock(ip);
80100b1a:	83 ec 0c             	sub    $0xc,%esp
80100b1d:	ff 75 08             	push   0x8(%ebp)
80100b20:	e8 fa 13 00 00       	call   80101f1f <iunlock>
80100b25:	83 c4 10             	add    $0x10,%esp
  target = n;
80100b28:	8b 45 10             	mov    0x10(%ebp),%eax
80100b2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100b2e:	83 ec 0c             	sub    $0xc,%esp
80100b31:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100b37:	50                   	push   %eax
80100b38:	e8 c5 4f 00 00       	call   80105b02 <acquire>
80100b3d:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100b40:	e9 b6 00 00 00       	jmp    80100bfb <consoleread+0xf3>
    while(input.r == input.w){
      if(myproc()->killed){
80100b45:	e8 5c 40 00 00       	call   80104ba6 <myproc>
80100b4a:	8b 40 24             	mov    0x24(%eax),%eax
80100b4d:	85 c0                	test   %eax,%eax
80100b4f:	74 2a                	je     80100b7b <consoleread+0x73>
        release(&cons.lock);
80100b51:	83 ec 0c             	sub    $0xc,%esp
80100b54:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100b5a:	50                   	push   %eax
80100b5b:	e8 1d 50 00 00       	call   80105b7d <release>
80100b60:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100b63:	83 ec 0c             	sub    $0xc,%esp
80100b66:	ff 75 08             	push   0x8(%ebp)
80100b69:	e8 8a 12 00 00       	call   80101df8 <ilock>
80100b6e:	83 c4 10             	add    $0x10,%esp
        return -1;
80100b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b76:	e9 b4 00 00 00       	jmp    80100c2f <consoleread+0x127>
      }
      sleep(&input.r, &cons.lock);
80100b7b:	83 ec 08             	sub    $0x8,%esp
80100b7e:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100b84:	50                   	push   %eax
80100b85:	8d 83 c0 4a 00 00    	lea    0x4ac0(%ebx),%eax
80100b8b:	50                   	push   %eax
80100b8c:	e8 ab 49 00 00       	call   8010553c <sleep>
80100b91:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100b94:	8b 93 c0 4a 00 00    	mov    0x4ac0(%ebx),%edx
80100b9a:	8b 83 c4 4a 00 00    	mov    0x4ac4(%ebx),%eax
80100ba0:	39 c2                	cmp    %eax,%edx
80100ba2:	74 a1                	je     80100b45 <consoleread+0x3d>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100ba4:	8b 83 c0 4a 00 00    	mov    0x4ac0(%ebx),%eax
80100baa:	8d 50 01             	lea    0x1(%eax),%edx
80100bad:	89 93 c0 4a 00 00    	mov    %edx,0x4ac0(%ebx)
80100bb3:	83 e0 7f             	and    $0x7f,%eax
80100bb6:	0f b6 84 03 40 4a 00 	movzbl 0x4a40(%ebx,%eax,1),%eax
80100bbd:	00 
80100bbe:	0f be c0             	movsbl %al,%eax
80100bc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100bc4:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100bc8:	75 19                	jne    80100be3 <consoleread+0xdb>
      if(n < target){
80100bca:	8b 45 10             	mov    0x10(%ebp),%eax
80100bcd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100bd0:	76 31                	jbe    80100c03 <consoleread+0xfb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100bd2:	8b 83 c0 4a 00 00    	mov    0x4ac0(%ebx),%eax
80100bd8:	83 e8 01             	sub    $0x1,%eax
80100bdb:	89 83 c0 4a 00 00    	mov    %eax,0x4ac0(%ebx)
      }
      break;
80100be1:	eb 20                	jmp    80100c03 <consoleread+0xfb>
    }
    *dst++ = c;
80100be3:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be6:	8d 50 01             	lea    0x1(%eax),%edx
80100be9:	89 55 0c             	mov    %edx,0xc(%ebp)
80100bec:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100bef:	88 10                	mov    %dl,(%eax)
    --n;
80100bf1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100bf5:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100bf9:	74 0b                	je     80100c06 <consoleread+0xfe>
  while(n > 0){
80100bfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100bff:	7f 93                	jg     80100b94 <consoleread+0x8c>
80100c01:	eb 04                	jmp    80100c07 <consoleread+0xff>
      break;
80100c03:	90                   	nop
80100c04:	eb 01                	jmp    80100c07 <consoleread+0xff>
      break;
80100c06:	90                   	nop
  }
  release(&cons.lock);
80100c07:	83 ec 0c             	sub    $0xc,%esp
80100c0a:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100c10:	50                   	push   %eax
80100c11:	e8 67 4f 00 00       	call   80105b7d <release>
80100c16:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100c19:	83 ec 0c             	sub    $0xc,%esp
80100c1c:	ff 75 08             	push   0x8(%ebp)
80100c1f:	e8 d4 11 00 00       	call   80101df8 <ilock>
80100c24:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100c27:	8b 55 10             	mov    0x10(%ebp),%edx
80100c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100c2d:	29 d0                	sub    %edx,%eax
}
80100c2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100c32:	c9                   	leave  
80100c33:	c3                   	ret    

80100c34 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100c34:	55                   	push   %ebp
80100c35:	89 e5                	mov    %esp,%ebp
80100c37:	53                   	push   %ebx
80100c38:	83 ec 14             	sub    $0x14,%esp
80100c3b:	e8 45 f7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100c40:	81 c3 80 b8 00 00    	add    $0xb880,%ebx
  int i;

  iunlock(ip);
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	ff 75 08             	push   0x8(%ebp)
80100c4c:	e8 ce 12 00 00       	call   80101f1f <iunlock>
80100c51:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100c54:	83 ec 0c             	sub    $0xc,%esp
80100c57:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100c5d:	50                   	push   %eax
80100c5e:	e8 9f 4e 00 00       	call   80105b02 <acquire>
80100c63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100c66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100c6d:	eb 21                	jmp    80100c90 <consolewrite+0x5c>
    consputc(buf[i] & 0xff);
80100c6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100c72:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c75:	01 d0                	add    %edx,%eax
80100c77:	0f b6 00             	movzbl (%eax),%eax
80100c7a:	0f be c0             	movsbl %al,%eax
80100c7d:	0f b6 c0             	movzbl %al,%eax
80100c80:	83 ec 0c             	sub    $0xc,%esp
80100c83:	50                   	push   %eax
80100c84:	e8 43 fc ff ff       	call   801008cc <consputc>
80100c89:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100c8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100c93:	3b 45 10             	cmp    0x10(%ebp),%eax
80100c96:	7c d7                	jl     80100c6f <consolewrite+0x3b>
  release(&cons.lock);
80100c98:	83 ec 0c             	sub    $0xc,%esp
80100c9b:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100ca1:	50                   	push   %eax
80100ca2:	e8 d6 4e 00 00       	call   80105b7d <release>
80100ca7:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100caa:	83 ec 0c             	sub    $0xc,%esp
80100cad:	ff 75 08             	push   0x8(%ebp)
80100cb0:	e8 43 11 00 00       	call   80101df8 <ilock>
80100cb5:	83 c4 10             	add    $0x10,%esp

  return n;
80100cb8:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100cbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100cbe:	c9                   	leave  
80100cbf:	c3                   	ret    

80100cc0 <consoleinit>:

void
consoleinit(void)
{
80100cc0:	55                   	push   %ebp
80100cc1:	89 e5                	mov    %esp,%ebp
80100cc3:	53                   	push   %ebx
80100cc4:	83 ec 04             	sub    $0x4,%esp
80100cc7:	e8 b9 f6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100ccc:	81 c3 f4 b7 00 00    	add    $0xb7f4,%ebx
  initlock(&cons.lock, "console");
80100cd2:	83 ec 08             	sub    $0x8,%esp
80100cd5:	8d 83 ce cf ff ff    	lea    -0x3032(%ebx),%eax
80100cdb:	50                   	push   %eax
80100cdc:	8d 83 e0 4a 00 00    	lea    0x4ae0(%ebx),%eax
80100ce2:	50                   	push   %eax
80100ce3:	e8 ee 4d 00 00       	call   80105ad6 <initlock>
80100ce8:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100ceb:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
80100cf1:	8d 93 74 47 ff ff    	lea    -0xb88c(%ebx),%edx
80100cf7:	89 50 0c             	mov    %edx,0xc(%eax)
  devsw[CONSOLE].read = consoleread;
80100cfa:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
80100d00:	8d 93 48 46 ff ff    	lea    -0xb9b8(%ebx),%edx
80100d06:	89 50 08             	mov    %edx,0x8(%eax)
  cons.locking = 1;
80100d09:	c7 83 14 4b 00 00 01 	movl   $0x1,0x4b14(%ebx)
80100d10:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100d13:	83 ec 08             	sub    $0x8,%esp
80100d16:	6a 00                	push   $0x0
80100d18:	6a 01                	push   $0x1
80100d1a:	e8 b8 23 00 00       	call   801030d7 <ioapicenable>
80100d1f:	83 c4 10             	add    $0x10,%esp
}
80100d22:	90                   	nop
80100d23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d26:	c9                   	leave  
80100d27:	c3                   	ret    

80100d28 <__x86.get_pc_thunk.ax>:
80100d28:	8b 04 24             	mov    (%esp),%eax
80100d2b:	c3                   	ret    

80100d2c <__x86.get_pc_thunk.cx>:
80100d2c:	8b 0c 24             	mov    (%esp),%ecx
80100d2f:	c3                   	ret    

80100d30 <randomrange>:
#include "x86.h"
#include "elf.h"

int
randomrange(int low, int high)
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	53                   	push   %ebx
80100d34:	83 ec 14             	sub    $0x14,%esp
80100d37:	e8 49 f6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100d3c:	81 c3 84 b7 00 00    	add    $0xb784,%ebx
  if (high < low) {
80100d42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d45:	3b 45 08             	cmp    0x8(%ebp),%eax
80100d48:	7d 12                	jge    80100d5c <randomrange+0x2c>
    int tmp = low;
80100d4a:	8b 45 08             	mov    0x8(%ebp),%eax
80100d4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    low = high;
80100d50:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d53:	89 45 08             	mov    %eax,0x8(%ebp)
    high = tmp;
80100d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d59:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  int range = high - low + 1;
80100d5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d5f:	2b 45 08             	sub    0x8(%ebp),%eax
80100d62:	83 c0 01             	add    $0x1,%eax
80100d65:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int rnd=random() % (range) + low;
80100d68:	e8 db 4a 00 00       	call   80105848 <random>
80100d6d:	99                   	cltd   
80100d6e:	f7 7d ec             	idivl  -0x14(%ebp)
80100d71:	8b 45 08             	mov    0x8(%ebp),%eax
80100d74:	01 d0                	add    %edx,%eax
80100d76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(rnd%2==0)
80100d79:	eb 11                	jmp    80100d8c <randomrange+0x5c>
  {
    rnd=random() % (range) + low;
80100d7b:	e8 c8 4a 00 00       	call   80105848 <random>
80100d80:	99                   	cltd   
80100d81:	f7 7d ec             	idivl  -0x14(%ebp)
80100d84:	8b 45 08             	mov    0x8(%ebp),%eax
80100d87:	01 d0                	add    %edx,%eax
80100d89:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(rnd%2==0)
80100d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100d8f:	83 e0 01             	and    $0x1,%eax
80100d92:	85 c0                	test   %eax,%eax
80100d94:	74 e5                	je     80100d7b <randomrange+0x4b>
  }
  return rnd;
80100d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100d99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d9c:	c9                   	leave  
80100d9d:	c3                   	ret    

80100d9e <exec>:



int
exec(char *path, char **argv)
{
80100d9e:	55                   	push   %ebp
80100d9f:	89 e5                	mov    %esp,%ebp
80100da1:	56                   	push   %esi
80100da2:	53                   	push   %ebx
80100da3:	81 ec 20 01 00 00    	sub    $0x120,%esp
80100da9:	e8 d7 f5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80100dae:	81 c3 12 b7 00 00    	add    $0xb712,%ebx
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100db4:	e8 ed 3d 00 00       	call   80104ba6 <myproc>
80100db9:	89 45 c4             	mov    %eax,-0x3c(%ebp)

  begin_op();
80100dbc:	e8 a8 2e 00 00       	call   80103c69 <begin_op>

  //Reading ASLR flag from file
  int aslr = 0;
80100dc1:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  char c[2] = {0};
80100dc8:	66 c7 85 da fe ff ff 	movw   $0x0,-0x126(%ebp)
80100dcf:	00 00 
  //   // {
  //   //   aslr = (c[0] == '1')? 1 : 0;
  //   // }
  //   iunlockput(ip);
  // }
  ip = namei("aslr_flag");
80100dd1:	83 ec 0c             	sub    $0xc,%esp
80100dd4:	8d 83 d6 cf ff ff    	lea    -0x302a(%ebx),%eax
80100dda:	50                   	push   %eax
80100ddb:	e8 46 1c 00 00       	call   80102a26 <namei>
80100de0:	83 c4 10             	add    $0x10,%esp
80100de3:	89 45 d8             	mov    %eax,-0x28(%ebp)
  ilock(ip);
80100de6:	83 ec 0c             	sub    $0xc,%esp
80100de9:	ff 75 d8             	push   -0x28(%ebp)
80100dec:	e8 07 10 00 00       	call   80101df8 <ilock>
80100df1:	83 c4 10             	add    $0x10,%esp
  readi(ip,&c[0], 0, sizeof(char));
80100df4:	6a 01                	push   $0x1
80100df6:	6a 00                	push   $0x0
80100df8:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
80100dfe:	50                   	push   %eax
80100dff:	ff 75 d8             	push   -0x28(%ebp)
80100e02:	e8 4d 15 00 00       	call   80102354 <readi>
80100e07:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80100e0a:	83 ec 0c             	sub    $0xc,%esp
80100e0d:	ff 75 d8             	push   -0x28(%ebp)
80100e10:	e8 50 12 00 00       	call   80102065 <iunlockput>
80100e15:	83 c4 10             	add    $0x10,%esp
  if(c[0]-'1'==0)
80100e18:	0f b6 85 da fe ff ff 	movzbl -0x126(%ebp),%eax
80100e1f:	3c 31                	cmp    $0x31,%al
80100e21:	75 07                	jne    80100e2a <exec+0x8c>
  {
    aslr=1;
80100e23:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  }
  // cprintf("aslr defined is %d\n",aslr);

  if((ip = namei(path)) == 0){
80100e2a:	83 ec 0c             	sub    $0xc,%esp
80100e2d:	ff 75 08             	push   0x8(%ebp)
80100e30:	e8 f1 1b 00 00       	call   80102a26 <namei>
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100e3b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100e3f:	75 21                	jne    80100e62 <exec+0xc4>
    end_op();
80100e41:	e8 ce 2e 00 00       	call   80103d14 <end_op>
    cprintf("exec: fail\n");
80100e46:	83 ec 0c             	sub    $0xc,%esp
80100e49:	8d 83 e0 cf ff ff    	lea    -0x3020(%ebx),%eax
80100e4f:	50                   	push   %eax
80100e50:	e8 53 f6 ff ff       	call   801004a8 <cprintf>
80100e55:	83 c4 10             	add    $0x10,%esp
    return -1;
80100e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e5d:	e9 3b 04 00 00       	jmp    8010129d <exec+0x4ff>
  }
  ilock(ip);
80100e62:	83 ec 0c             	sub    $0xc,%esp
80100e65:	ff 75 d8             	push   -0x28(%ebp)
80100e68:	e8 8b 0f 00 00       	call   80101df8 <ilock>
80100e6d:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100e70:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  
  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100e77:	6a 34                	push   $0x34
80100e79:	6a 00                	push   $0x0
80100e7b:	8d 85 fc fe ff ff    	lea    -0x104(%ebp),%eax
80100e81:	50                   	push   %eax
80100e82:	ff 75 d8             	push   -0x28(%ebp)
80100e85:	e8 ca 14 00 00       	call   80102354 <readi>
80100e8a:	83 c4 10             	add    $0x10,%esp
80100e8d:	83 f8 34             	cmp    $0x34,%eax
80100e90:	0f 85 b0 03 00 00    	jne    80101246 <exec+0x4a8>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100e96:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100e9c:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100ea1:	0f 85 a2 03 00 00    	jne    80101249 <exec+0x4ab>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100ea7:	e8 a3 7b 00 00       	call   80108a4f <setupkvm>
80100eac:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100eaf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100eb3:	0f 84 93 03 00 00    	je     8010124c <exec+0x4ae>
    goto bad;

  // Load program into memory.
  uint random_lookahead = 0;
80100eb9:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  if(aslr==1)
80100ec0:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
80100ec4:	75 07                	jne    80100ecd <exec+0x12f>
  {
    random_lookahead=5000;//(uint)randomrange(500,4000);
80100ec6:	c7 45 cc 88 13 00 00 	movl   $0x1388,-0x34(%ebp)
  }
  // cprintf("the random no generated is,%d\n",random_lookahead);
  sz=0;
80100ecd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph))
80100ed4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100edb:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ee1:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ee4:	e9 e8 00 00 00       	jmp    80100fd1 <exec+0x233>
  {
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100ee9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100eec:	6a 20                	push   $0x20
80100eee:	50                   	push   %eax
80100eef:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
80100ef5:	50                   	push   %eax
80100ef6:	ff 75 d8             	push   -0x28(%ebp)
80100ef9:	e8 56 14 00 00       	call   80102354 <readi>
80100efe:	83 c4 10             	add    $0x10,%esp
80100f01:	83 f8 20             	cmp    $0x20,%eax
80100f04:	0f 85 45 03 00 00    	jne    8010124f <exec+0x4b1>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100f0a:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
80100f10:	83 f8 01             	cmp    $0x1,%eax
80100f13:	0f 85 aa 00 00 00    	jne    80100fc3 <exec+0x225>
      continue;
    if(ph.memsz < ph.filesz)
80100f19:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100f1f:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100f25:	39 c2                	cmp    %eax,%edx
80100f27:	0f 82 25 03 00 00    	jb     80101252 <exec+0x4b4>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100f2d:	8b 95 e4 fe ff ff    	mov    -0x11c(%ebp),%edx
80100f33:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100f39:	01 c2                	add    %eax,%edx
80100f3b:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
80100f41:	39 c2                	cmp    %eax,%edx
80100f43:	0f 82 0c 03 00 00    	jb     80101255 <exec+0x4b7>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz+random_lookahead)) == 0)  //add offset
80100f49:	8b 95 e4 fe ff ff    	mov    -0x11c(%ebp),%edx
80100f4f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100f55:	01 c2                	add    %eax,%edx
80100f57:	8b 45 cc             	mov    -0x34(%ebp),%eax
80100f5a:	01 d0                	add    %edx,%eax
80100f5c:	83 ec 04             	sub    $0x4,%esp
80100f5f:	50                   	push   %eax
80100f60:	ff 75 e0             	push   -0x20(%ebp)
80100f63:	ff 75 d4             	push   -0x2c(%ebp)
80100f66:	e8 9a 7f 00 00       	call   80108f05 <allocuvm>
80100f6b:	83 c4 10             	add    $0x10,%esp
80100f6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100f71:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100f75:	0f 84 dd 02 00 00    	je     80101258 <exec+0x4ba>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100f7b:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
80100f81:	25 ff 0f 00 00       	and    $0xfff,%eax
80100f86:	85 c0                	test   %eax,%eax
80100f88:	0f 85 cd 02 00 00    	jne    8010125b <exec+0x4bd>
      goto bad;
    if(loaduvm(pgdir, (char*)(ph.vaddr+random_lookahead), ip, ph.off, ph.filesz) < 0)  //add offset
80100f8e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
80100f94:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
80100f9a:	8b b5 e4 fe ff ff    	mov    -0x11c(%ebp),%esi
80100fa0:	8b 4d cc             	mov    -0x34(%ebp),%ecx
80100fa3:	01 f1                	add    %esi,%ecx
80100fa5:	83 ec 0c             	sub    $0xc,%esp
80100fa8:	52                   	push   %edx
80100fa9:	50                   	push   %eax
80100faa:	ff 75 d8             	push   -0x28(%ebp)
80100fad:	51                   	push   %ecx
80100fae:	ff 75 d4             	push   -0x2c(%ebp)
80100fb1:	e8 c3 7d 00 00       	call   80108d79 <loaduvm>
80100fb6:	83 c4 20             	add    $0x20,%esp
80100fb9:	85 c0                	test   %eax,%eax
80100fbb:	0f 88 9d 02 00 00    	js     8010125e <exec+0x4c0>
80100fc1:	eb 01                	jmp    80100fc4 <exec+0x226>
      continue;
80100fc3:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph))
80100fc4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100fc8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100fcb:	83 c0 20             	add    $0x20,%eax
80100fce:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100fd1:	0f b7 85 28 ff ff ff 	movzwl -0xd8(%ebp),%eax
80100fd8:	0f b7 c0             	movzwl %ax,%eax
80100fdb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100fde:	0f 8c 05 ff ff ff    	jl     80100ee9 <exec+0x14b>
      goto bad;
  }
  iunlockput(ip);
80100fe4:	83 ec 0c             	sub    $0xc,%esp
80100fe7:	ff 75 d8             	push   -0x28(%ebp)
80100fea:	e8 76 10 00 00       	call   80102065 <iunlockput>
80100fef:	83 c4 10             	add    $0x10,%esp
  end_op();
80100ff2:	e8 1d 2d 00 00       	call   80103d14 <end_op>
  ip = 0;
80100ff7:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ffe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101001:	05 ff 0f 00 00       	add    $0xfff,%eax
80101006:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010100b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  uint rr=0;
8010100e:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  if(aslr==1)
80101015:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
80101019:	75 12                	jne    8010102d <exec+0x28f>
    rr=randomrange(0,10);
8010101b:	83 ec 08             	sub    $0x8,%esp
8010101e:	6a 0a                	push   $0xa
80101020:	6a 00                	push   $0x0
80101022:	e8 09 fd ff ff       	call   80100d30 <randomrange>
80101027:	83 c4 10             	add    $0x10,%esp
8010102a:	89 45 c8             	mov    %eax,-0x38(%ebp)

  if((sz = allocuvm(pgdir, sz, sz + (2+rr)*PGSIZE)) == 0)
8010102d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80101030:	83 c0 02             	add    $0x2,%eax
80101033:	c1 e0 0c             	shl    $0xc,%eax
80101036:	89 c2                	mov    %eax,%edx
80101038:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010103b:	01 d0                	add    %edx,%eax
8010103d:	83 ec 04             	sub    $0x4,%esp
80101040:	50                   	push   %eax
80101041:	ff 75 e0             	push   -0x20(%ebp)
80101044:	ff 75 d4             	push   -0x2c(%ebp)
80101047:	e8 b9 7e 00 00       	call   80108f05 <allocuvm>
8010104c:	83 c4 10             	add    $0x10,%esp
8010104f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101052:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80101056:	0f 84 05 02 00 00    	je     80101261 <exec+0x4c3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010105c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010105f:	2d 00 20 00 00       	sub    $0x2000,%eax
80101064:	83 ec 08             	sub    $0x8,%esp
80101067:	50                   	push   %eax
80101068:	ff 75 d4             	push   -0x2c(%ebp)
8010106b:	e8 2c 81 00 00       	call   8010919c <clearpteu>
80101070:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80101073:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101076:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101079:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101080:	e9 96 00 00 00       	jmp    8010111b <exec+0x37d>
    if(argc >= MAXARG)
80101085:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80101089:	0f 87 d5 01 00 00    	ja     80101264 <exec+0x4c6>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010108f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101092:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101099:	8b 45 0c             	mov    0xc(%ebp),%eax
8010109c:	01 d0                	add    %edx,%eax
8010109e:	8b 00                	mov    (%eax),%eax
801010a0:	83 ec 0c             	sub    $0xc,%esp
801010a3:	50                   	push   %eax
801010a4:	e8 df 4f 00 00       	call   80106088 <strlen>
801010a9:	83 c4 10             	add    $0x10,%esp
801010ac:	89 c2                	mov    %eax,%edx
801010ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010b1:	29 d0                	sub    %edx,%eax
801010b3:	83 e8 01             	sub    $0x1,%eax
801010b6:	83 e0 fc             	and    $0xfffffffc,%eax
801010b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801010bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801010c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801010c9:	01 d0                	add    %edx,%eax
801010cb:	8b 00                	mov    (%eax),%eax
801010cd:	83 ec 0c             	sub    $0xc,%esp
801010d0:	50                   	push   %eax
801010d1:	e8 b2 4f 00 00       	call   80106088 <strlen>
801010d6:	83 c4 10             	add    $0x10,%esp
801010d9:	83 c0 01             	add    $0x1,%eax
801010dc:	89 c2                	mov    %eax,%edx
801010de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010e1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
801010e8:	8b 45 0c             	mov    0xc(%ebp),%eax
801010eb:	01 c8                	add    %ecx,%eax
801010ed:	8b 00                	mov    (%eax),%eax
801010ef:	52                   	push   %edx
801010f0:	50                   	push   %eax
801010f1:	ff 75 dc             	push   -0x24(%ebp)
801010f4:	ff 75 d4             	push   -0x2c(%ebp)
801010f7:	e8 7a 82 00 00       	call   80109376 <copyout>
801010fc:	83 c4 10             	add    $0x10,%esp
801010ff:	85 c0                	test   %eax,%eax
80101101:	0f 88 60 01 00 00    	js     80101267 <exec+0x4c9>
      goto bad;
    ustack[3+argc] = sp;
80101107:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010110a:	8d 50 03             	lea    0x3(%eax),%edx
8010110d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101110:	89 84 95 30 ff ff ff 	mov    %eax,-0xd0(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80101117:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010111b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010111e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101125:	8b 45 0c             	mov    0xc(%ebp),%eax
80101128:	01 d0                	add    %edx,%eax
8010112a:	8b 00                	mov    (%eax),%eax
8010112c:	85 c0                	test   %eax,%eax
8010112e:	0f 85 51 ff ff ff    	jne    80101085 <exec+0x2e7>
  }
  ustack[3+argc] = 0;
80101134:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101137:	83 c0 03             	add    $0x3,%eax
8010113a:	c7 84 85 30 ff ff ff 	movl   $0x0,-0xd0(%ebp,%eax,4)
80101141:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101145:	c7 85 30 ff ff ff ff 	movl   $0xffffffff,-0xd0(%ebp)
8010114c:	ff ff ff 
  ustack[1] = argc;
8010114f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101152:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101158:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010115b:	83 c0 01             	add    $0x1,%eax
8010115e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101165:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101168:	29 d0                	sub    %edx,%eax
8010116a:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)

  sp -= (3+argc+1) * 4;
80101170:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101173:	83 c0 04             	add    $0x4,%eax
80101176:	c1 e0 02             	shl    $0x2,%eax
80101179:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010117c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010117f:	83 c0 04             	add    $0x4,%eax
80101182:	c1 e0 02             	shl    $0x2,%eax
80101185:	50                   	push   %eax
80101186:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
8010118c:	50                   	push   %eax
8010118d:	ff 75 dc             	push   -0x24(%ebp)
80101190:	ff 75 d4             	push   -0x2c(%ebp)
80101193:	e8 de 81 00 00       	call   80109376 <copyout>
80101198:	83 c4 10             	add    $0x10,%esp
8010119b:	85 c0                	test   %eax,%eax
8010119d:	0f 88 c7 00 00 00    	js     8010126a <exec+0x4cc>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801011a3:	8b 45 08             	mov    0x8(%ebp),%eax
801011a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
801011af:	eb 17                	jmp    801011c8 <exec+0x42a>
    if(*s == '/')
801011b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011b4:	0f b6 00             	movzbl (%eax),%eax
801011b7:	3c 2f                	cmp    $0x2f,%al
801011b9:	75 09                	jne    801011c4 <exec+0x426>
      last = s+1;
801011bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011be:	83 c0 01             	add    $0x1,%eax
801011c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
801011c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801011c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011cb:	0f b6 00             	movzbl (%eax),%eax
801011ce:	84 c0                	test   %al,%al
801011d0:	75 df                	jne    801011b1 <exec+0x413>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
801011d2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801011d5:	83 c0 6c             	add    $0x6c,%eax
801011d8:	83 ec 04             	sub    $0x4,%esp
801011db:	6a 10                	push   $0x10
801011dd:	ff 75 f0             	push   -0x10(%ebp)
801011e0:	50                   	push   %eax
801011e1:	e8 4d 4e 00 00       	call   80106033 <safestrcpy>
801011e6:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
801011e9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801011ec:	8b 40 04             	mov    0x4(%eax),%eax
801011ef:	89 45 c0             	mov    %eax,-0x40(%ebp)
  curproc->pgdir = pgdir;
801011f2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801011f5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801011f8:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
801011fb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801011fe:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101201:	89 10                	mov    %edx,(%eax)
  curproc->tf->eip = elf.entry+random_lookahead;  // main
80101203:	8b 8d 14 ff ff ff    	mov    -0xec(%ebp),%ecx
80101209:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010120c:	8b 40 18             	mov    0x18(%eax),%eax
8010120f:	8b 55 cc             	mov    -0x34(%ebp),%edx
80101212:	01 ca                	add    %ecx,%edx
80101214:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101217:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010121a:	8b 40 18             	mov    0x18(%eax),%eax
8010121d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101220:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(curproc);
80101223:	83 ec 0c             	sub    $0xc,%esp
80101226:	ff 75 c4             	push   -0x3c(%ebp)
80101229:	e8 18 79 00 00       	call   80108b46 <switchuvm>
8010122e:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	ff 75 c0             	push   -0x40(%ebp)
80101237:	e8 b6 7e 00 00       	call   801090f2 <freevm>
8010123c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010123f:	b8 00 00 00 00       	mov    $0x0,%eax
80101244:	eb 57                	jmp    8010129d <exec+0x4ff>
    goto bad;
80101246:	90                   	nop
80101247:	eb 22                	jmp    8010126b <exec+0x4cd>
    goto bad;
80101249:	90                   	nop
8010124a:	eb 1f                	jmp    8010126b <exec+0x4cd>
    goto bad;
8010124c:	90                   	nop
8010124d:	eb 1c                	jmp    8010126b <exec+0x4cd>
      goto bad;
8010124f:	90                   	nop
80101250:	eb 19                	jmp    8010126b <exec+0x4cd>
      goto bad;
80101252:	90                   	nop
80101253:	eb 16                	jmp    8010126b <exec+0x4cd>
      goto bad;
80101255:	90                   	nop
80101256:	eb 13                	jmp    8010126b <exec+0x4cd>
      goto bad;
80101258:	90                   	nop
80101259:	eb 10                	jmp    8010126b <exec+0x4cd>
      goto bad;
8010125b:	90                   	nop
8010125c:	eb 0d                	jmp    8010126b <exec+0x4cd>
      goto bad;
8010125e:	90                   	nop
8010125f:	eb 0a                	jmp    8010126b <exec+0x4cd>
    goto bad;
80101261:	90                   	nop
80101262:	eb 07                	jmp    8010126b <exec+0x4cd>
      goto bad;
80101264:	90                   	nop
80101265:	eb 04                	jmp    8010126b <exec+0x4cd>
      goto bad;
80101267:	90                   	nop
80101268:	eb 01                	jmp    8010126b <exec+0x4cd>
    goto bad;
8010126a:	90                   	nop

 bad:
  if(pgdir)
8010126b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
8010126f:	74 0e                	je     8010127f <exec+0x4e1>
    freevm(pgdir);
80101271:	83 ec 0c             	sub    $0xc,%esp
80101274:	ff 75 d4             	push   -0x2c(%ebp)
80101277:	e8 76 7e 00 00       	call   801090f2 <freevm>
8010127c:	83 c4 10             	add    $0x10,%esp
  if(ip){
8010127f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80101283:	74 13                	je     80101298 <exec+0x4fa>
    iunlockput(ip);
80101285:	83 ec 0c             	sub    $0xc,%esp
80101288:	ff 75 d8             	push   -0x28(%ebp)
8010128b:	e8 d5 0d 00 00       	call   80102065 <iunlockput>
80101290:	83 c4 10             	add    $0x10,%esp
    end_op();
80101293:	e8 7c 2a 00 00       	call   80103d14 <end_op>
  }
  return -1;
80101298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010129d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012a0:	5b                   	pop    %ebx
801012a1:	5e                   	pop    %esi
801012a2:	5d                   	pop    %ebp
801012a3:	c3                   	ret    

801012a4 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801012a4:	55                   	push   %ebp
801012a5:	89 e5                	mov    %esp,%ebp
801012a7:	53                   	push   %ebx
801012a8:	83 ec 04             	sub    $0x4,%esp
801012ab:	e8 78 fa ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801012b0:	05 10 b2 00 00       	add    $0xb210,%eax
  initlock(&ftable.lock, "ftable");
801012b5:	83 ec 08             	sub    $0x8,%esp
801012b8:	8d 90 ec cf ff ff    	lea    -0x3014(%eax),%edx
801012be:	52                   	push   %edx
801012bf:	8d 90 80 4b 00 00    	lea    0x4b80(%eax),%edx
801012c5:	52                   	push   %edx
801012c6:	89 c3                	mov    %eax,%ebx
801012c8:	e8 09 48 00 00       	call   80105ad6 <initlock>
801012cd:	83 c4 10             	add    $0x10,%esp
}
801012d0:	90                   	nop
801012d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801012d4:	c9                   	leave  
801012d5:	c3                   	ret    

801012d6 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801012d6:	55                   	push   %ebp
801012d7:	89 e5                	mov    %esp,%ebp
801012d9:	53                   	push   %ebx
801012da:	83 ec 14             	sub    $0x14,%esp
801012dd:	e8 a3 f0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801012e2:	81 c3 de b1 00 00    	add    $0xb1de,%ebx
  struct file *f;

  acquire(&ftable.lock);
801012e8:	83 ec 0c             	sub    $0xc,%esp
801012eb:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
801012f1:	50                   	push   %eax
801012f2:	e8 0b 48 00 00       	call   80105b02 <acquire>
801012f7:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012fa:	8d 83 b4 4b 00 00    	lea    0x4bb4(%ebx),%eax
80101300:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101303:	eb 2f                	jmp    80101334 <filealloc+0x5e>
    if(f->ref == 0){
80101305:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101308:	8b 40 04             	mov    0x4(%eax),%eax
8010130b:	85 c0                	test   %eax,%eax
8010130d:	75 21                	jne    80101330 <filealloc+0x5a>
      f->ref = 1;
8010130f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101312:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101319:	83 ec 0c             	sub    $0xc,%esp
8010131c:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
80101322:	50                   	push   %eax
80101323:	e8 55 48 00 00       	call   80105b7d <release>
80101328:	83 c4 10             	add    $0x10,%esp
      return f;
8010132b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010132e:	eb 26                	jmp    80101356 <filealloc+0x80>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101330:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101334:	8d 83 14 55 00 00    	lea    0x5514(%ebx),%eax
8010133a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010133d:	72 c6                	jb     80101305 <filealloc+0x2f>
    }
  }
  release(&ftable.lock);
8010133f:	83 ec 0c             	sub    $0xc,%esp
80101342:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
80101348:	50                   	push   %eax
80101349:	e8 2f 48 00 00       	call   80105b7d <release>
8010134e:	83 c4 10             	add    $0x10,%esp
  return 0;
80101351:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101356:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101359:	c9                   	leave  
8010135a:	c3                   	ret    

8010135b <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010135b:	55                   	push   %ebp
8010135c:	89 e5                	mov    %esp,%ebp
8010135e:	53                   	push   %ebx
8010135f:	83 ec 04             	sub    $0x4,%esp
80101362:	e8 1e f0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101367:	81 c3 59 b1 00 00    	add    $0xb159,%ebx
  acquire(&ftable.lock);
8010136d:	83 ec 0c             	sub    $0xc,%esp
80101370:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
80101376:	50                   	push   %eax
80101377:	e8 86 47 00 00       	call   80105b02 <acquire>
8010137c:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010137f:	8b 45 08             	mov    0x8(%ebp),%eax
80101382:	8b 40 04             	mov    0x4(%eax),%eax
80101385:	85 c0                	test   %eax,%eax
80101387:	7f 0f                	jg     80101398 <filedup+0x3d>
    panic("filedup");
80101389:	83 ec 0c             	sub    $0xc,%esp
8010138c:	8d 83 f3 cf ff ff    	lea    -0x300d(%ebx),%eax
80101392:	50                   	push   %eax
80101393:	e8 dd f2 ff ff       	call   80100675 <panic>
  f->ref++;
80101398:	8b 45 08             	mov    0x8(%ebp),%eax
8010139b:	8b 40 04             	mov    0x4(%eax),%eax
8010139e:	8d 50 01             	lea    0x1(%eax),%edx
801013a1:	8b 45 08             	mov    0x8(%ebp),%eax
801013a4:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801013a7:	83 ec 0c             	sub    $0xc,%esp
801013aa:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
801013b0:	50                   	push   %eax
801013b1:	e8 c7 47 00 00       	call   80105b7d <release>
801013b6:	83 c4 10             	add    $0x10,%esp
  return f;
801013b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
801013bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013bf:	c9                   	leave  
801013c0:	c3                   	ret    

801013c1 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801013c1:	55                   	push   %ebp
801013c2:	89 e5                	mov    %esp,%ebp
801013c4:	53                   	push   %ebx
801013c5:	83 ec 24             	sub    $0x24,%esp
801013c8:	e8 b8 ef ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801013cd:	81 c3 f3 b0 00 00    	add    $0xb0f3,%ebx
  struct file ff;

  acquire(&ftable.lock);
801013d3:	83 ec 0c             	sub    $0xc,%esp
801013d6:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
801013dc:	50                   	push   %eax
801013dd:	e8 20 47 00 00       	call   80105b02 <acquire>
801013e2:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801013e5:	8b 45 08             	mov    0x8(%ebp),%eax
801013e8:	8b 40 04             	mov    0x4(%eax),%eax
801013eb:	85 c0                	test   %eax,%eax
801013ed:	7f 0f                	jg     801013fe <fileclose+0x3d>
    panic("fileclose");
801013ef:	83 ec 0c             	sub    $0xc,%esp
801013f2:	8d 83 fb cf ff ff    	lea    -0x3005(%ebx),%eax
801013f8:	50                   	push   %eax
801013f9:	e8 77 f2 ff ff       	call   80100675 <panic>
  if(--f->ref > 0){
801013fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101401:	8b 40 04             	mov    0x4(%eax),%eax
80101404:	8d 50 ff             	lea    -0x1(%eax),%edx
80101407:	8b 45 08             	mov    0x8(%ebp),%eax
8010140a:	89 50 04             	mov    %edx,0x4(%eax)
8010140d:	8b 45 08             	mov    0x8(%ebp),%eax
80101410:	8b 40 04             	mov    0x4(%eax),%eax
80101413:	85 c0                	test   %eax,%eax
80101415:	7e 17                	jle    8010142e <fileclose+0x6d>
    release(&ftable.lock);
80101417:	83 ec 0c             	sub    $0xc,%esp
8010141a:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
80101420:	50                   	push   %eax
80101421:	e8 57 47 00 00       	call   80105b7d <release>
80101426:	83 c4 10             	add    $0x10,%esp
80101429:	e9 8d 00 00 00       	jmp    801014bb <fileclose+0xfa>
    return;
  }
  ff = *f;
8010142e:	8b 45 08             	mov    0x8(%ebp),%eax
80101431:	8b 10                	mov    (%eax),%edx
80101433:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101436:	8b 50 04             	mov    0x4(%eax),%edx
80101439:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010143c:	8b 50 08             	mov    0x8(%eax),%edx
8010143f:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101442:	8b 50 0c             	mov    0xc(%eax),%edx
80101445:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101448:	8b 50 10             	mov    0x10(%eax),%edx
8010144b:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010144e:	8b 40 14             	mov    0x14(%eax),%eax
80101451:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101454:	8b 45 08             	mov    0x8(%ebp),%eax
80101457:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010145e:	8b 45 08             	mov    0x8(%ebp),%eax
80101461:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101467:	83 ec 0c             	sub    $0xc,%esp
8010146a:	8d 83 80 4b 00 00    	lea    0x4b80(%ebx),%eax
80101470:	50                   	push   %eax
80101471:	e8 07 47 00 00       	call   80105b7d <release>
80101476:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
80101479:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010147c:	83 f8 01             	cmp    $0x1,%eax
8010147f:	75 19                	jne    8010149a <fileclose+0xd9>
    pipeclose(ff.pipe, ff.writable);
80101481:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101485:	0f be d0             	movsbl %al,%edx
80101488:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010148b:	83 ec 08             	sub    $0x8,%esp
8010148e:	52                   	push   %edx
8010148f:	50                   	push   %eax
80101490:	e8 1e 33 00 00       	call   801047b3 <pipeclose>
80101495:	83 c4 10             	add    $0x10,%esp
80101498:	eb 21                	jmp    801014bb <fileclose+0xfa>
  else if(ff.type == FD_INODE){
8010149a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010149d:	83 f8 02             	cmp    $0x2,%eax
801014a0:	75 19                	jne    801014bb <fileclose+0xfa>
    begin_op();
801014a2:	e8 c2 27 00 00       	call   80103c69 <begin_op>
    iput(ff.ip);
801014a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014aa:	83 ec 0c             	sub    $0xc,%esp
801014ad:	50                   	push   %eax
801014ae:	e8 cb 0a 00 00       	call   80101f7e <iput>
801014b3:	83 c4 10             	add    $0x10,%esp
    end_op();
801014b6:	e8 59 28 00 00       	call   80103d14 <end_op>
  }
}
801014bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014be:	c9                   	leave  
801014bf:	c3                   	ret    

801014c0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	53                   	push   %ebx
801014c4:	83 ec 04             	sub    $0x4,%esp
801014c7:	e8 b9 ee ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801014cc:	81 c3 f4 af 00 00    	add    $0xaff4,%ebx
  if(f->type == FD_INODE){
801014d2:	8b 45 08             	mov    0x8(%ebp),%eax
801014d5:	8b 00                	mov    (%eax),%eax
801014d7:	83 f8 02             	cmp    $0x2,%eax
801014da:	75 40                	jne    8010151c <filestat+0x5c>
    ilock(f->ip);
801014dc:	8b 45 08             	mov    0x8(%ebp),%eax
801014df:	8b 40 10             	mov    0x10(%eax),%eax
801014e2:	83 ec 0c             	sub    $0xc,%esp
801014e5:	50                   	push   %eax
801014e6:	e8 0d 09 00 00       	call   80101df8 <ilock>
801014eb:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801014ee:	8b 45 08             	mov    0x8(%ebp),%eax
801014f1:	8b 40 10             	mov    0x10(%eax),%eax
801014f4:	83 ec 08             	sub    $0x8,%esp
801014f7:	ff 75 0c             	push   0xc(%ebp)
801014fa:	50                   	push   %eax
801014fb:	e8 04 0e 00 00       	call   80102304 <stati>
80101500:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101503:	8b 45 08             	mov    0x8(%ebp),%eax
80101506:	8b 40 10             	mov    0x10(%eax),%eax
80101509:	83 ec 0c             	sub    $0xc,%esp
8010150c:	50                   	push   %eax
8010150d:	e8 0d 0a 00 00       	call   80101f1f <iunlock>
80101512:	83 c4 10             	add    $0x10,%esp
    return 0;
80101515:	b8 00 00 00 00       	mov    $0x0,%eax
8010151a:	eb 05                	jmp    80101521 <filestat+0x61>
  }
  return -1;
8010151c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101524:	c9                   	leave  
80101525:	c3                   	ret    

80101526 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101526:	55                   	push   %ebp
80101527:	89 e5                	mov    %esp,%ebp
80101529:	53                   	push   %ebx
8010152a:	83 ec 14             	sub    $0x14,%esp
8010152d:	e8 53 ee ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101532:	81 c3 8e af 00 00    	add    $0xaf8e,%ebx
  int r;

  if(f->readable == 0)
80101538:	8b 45 08             	mov    0x8(%ebp),%eax
8010153b:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010153f:	84 c0                	test   %al,%al
80101541:	75 0a                	jne    8010154d <fileread+0x27>
    return -1;
80101543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101548:	e9 9d 00 00 00       	jmp    801015ea <fileread+0xc4>
  if(f->type == FD_PIPE)
8010154d:	8b 45 08             	mov    0x8(%ebp),%eax
80101550:	8b 00                	mov    (%eax),%eax
80101552:	83 f8 01             	cmp    $0x1,%eax
80101555:	75 1a                	jne    80101571 <fileread+0x4b>
    return piperead(f->pipe, addr, n);
80101557:	8b 45 08             	mov    0x8(%ebp),%eax
8010155a:	8b 40 0c             	mov    0xc(%eax),%eax
8010155d:	83 ec 04             	sub    $0x4,%esp
80101560:	ff 75 10             	push   0x10(%ebp)
80101563:	ff 75 0c             	push   0xc(%ebp)
80101566:	50                   	push   %eax
80101567:	e8 11 34 00 00       	call   8010497d <piperead>
8010156c:	83 c4 10             	add    $0x10,%esp
8010156f:	eb 79                	jmp    801015ea <fileread+0xc4>
  if(f->type == FD_INODE){
80101571:	8b 45 08             	mov    0x8(%ebp),%eax
80101574:	8b 00                	mov    (%eax),%eax
80101576:	83 f8 02             	cmp    $0x2,%eax
80101579:	75 60                	jne    801015db <fileread+0xb5>
    ilock(f->ip);
8010157b:	8b 45 08             	mov    0x8(%ebp),%eax
8010157e:	8b 40 10             	mov    0x10(%eax),%eax
80101581:	83 ec 0c             	sub    $0xc,%esp
80101584:	50                   	push   %eax
80101585:	e8 6e 08 00 00       	call   80101df8 <ilock>
8010158a:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010158d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101590:	8b 45 08             	mov    0x8(%ebp),%eax
80101593:	8b 50 14             	mov    0x14(%eax),%edx
80101596:	8b 45 08             	mov    0x8(%ebp),%eax
80101599:	8b 40 10             	mov    0x10(%eax),%eax
8010159c:	51                   	push   %ecx
8010159d:	52                   	push   %edx
8010159e:	ff 75 0c             	push   0xc(%ebp)
801015a1:	50                   	push   %eax
801015a2:	e8 ad 0d 00 00       	call   80102354 <readi>
801015a7:	83 c4 10             	add    $0x10,%esp
801015aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
801015ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801015b1:	7e 11                	jle    801015c4 <fileread+0x9e>
      f->off += r;
801015b3:	8b 45 08             	mov    0x8(%ebp),%eax
801015b6:	8b 50 14             	mov    0x14(%eax),%edx
801015b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015bc:	01 c2                	add    %eax,%edx
801015be:	8b 45 08             	mov    0x8(%ebp),%eax
801015c1:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801015c4:	8b 45 08             	mov    0x8(%ebp),%eax
801015c7:	8b 40 10             	mov    0x10(%eax),%eax
801015ca:	83 ec 0c             	sub    $0xc,%esp
801015cd:	50                   	push   %eax
801015ce:	e8 4c 09 00 00       	call   80101f1f <iunlock>
801015d3:	83 c4 10             	add    $0x10,%esp
    return r;
801015d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015d9:	eb 0f                	jmp    801015ea <fileread+0xc4>
  }
  panic("fileread");
801015db:	83 ec 0c             	sub    $0xc,%esp
801015de:	8d 83 05 d0 ff ff    	lea    -0x2ffb(%ebx),%eax
801015e4:	50                   	push   %eax
801015e5:	e8 8b f0 ff ff       	call   80100675 <panic>
}
801015ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015ed:	c9                   	leave  
801015ee:	c3                   	ret    

801015ef <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801015ef:	55                   	push   %ebp
801015f0:	89 e5                	mov    %esp,%ebp
801015f2:	56                   	push   %esi
801015f3:	53                   	push   %ebx
801015f4:	83 ec 10             	sub    $0x10,%esp
801015f7:	e8 89 ed ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801015fc:	81 c3 c4 ae 00 00    	add    $0xaec4,%ebx
  int r;

  if(f->writable == 0)
80101602:	8b 45 08             	mov    0x8(%ebp),%eax
80101605:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101609:	84 c0                	test   %al,%al
8010160b:	75 0a                	jne    80101617 <filewrite+0x28>
    return -1;
8010160d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101612:	e9 1f 01 00 00       	jmp    80101736 <filewrite+0x147>
  if(f->type == FD_PIPE)
80101617:	8b 45 08             	mov    0x8(%ebp),%eax
8010161a:	8b 00                	mov    (%eax),%eax
8010161c:	83 f8 01             	cmp    $0x1,%eax
8010161f:	75 1d                	jne    8010163e <filewrite+0x4f>
    return pipewrite(f->pipe, addr, n);
80101621:	8b 45 08             	mov    0x8(%ebp),%eax
80101624:	8b 40 0c             	mov    0xc(%eax),%eax
80101627:	83 ec 04             	sub    $0x4,%esp
8010162a:	ff 75 10             	push   0x10(%ebp)
8010162d:	ff 75 0c             	push   0xc(%ebp)
80101630:	50                   	push   %eax
80101631:	e8 37 32 00 00       	call   8010486d <pipewrite>
80101636:	83 c4 10             	add    $0x10,%esp
80101639:	e9 f8 00 00 00       	jmp    80101736 <filewrite+0x147>
  if(f->type == FD_INODE){
8010163e:	8b 45 08             	mov    0x8(%ebp),%eax
80101641:	8b 00                	mov    (%eax),%eax
80101643:	83 f8 02             	cmp    $0x2,%eax
80101646:	0f 85 db 00 00 00    	jne    80101727 <filewrite+0x138>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
8010164c:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101653:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010165a:	e9 a5 00 00 00       	jmp    80101704 <filewrite+0x115>
      int n1 = n - i;
8010165f:	8b 45 10             	mov    0x10(%ebp),%eax
80101662:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101665:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101668:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010166b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010166e:	7e 06                	jle    80101676 <filewrite+0x87>
        n1 = max;
80101670:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101673:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101676:	e8 ee 25 00 00       	call   80103c69 <begin_op>
      ilock(f->ip);
8010167b:	8b 45 08             	mov    0x8(%ebp),%eax
8010167e:	8b 40 10             	mov    0x10(%eax),%eax
80101681:	83 ec 0c             	sub    $0xc,%esp
80101684:	50                   	push   %eax
80101685:	e8 6e 07 00 00       	call   80101df8 <ilock>
8010168a:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010168d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101690:	8b 45 08             	mov    0x8(%ebp),%eax
80101693:	8b 50 14             	mov    0x14(%eax),%edx
80101696:	8b 75 f4             	mov    -0xc(%ebp),%esi
80101699:	8b 45 0c             	mov    0xc(%ebp),%eax
8010169c:	01 c6                	add    %eax,%esi
8010169e:	8b 45 08             	mov    0x8(%ebp),%eax
801016a1:	8b 40 10             	mov    0x10(%eax),%eax
801016a4:	51                   	push   %ecx
801016a5:	52                   	push   %edx
801016a6:	56                   	push   %esi
801016a7:	50                   	push   %eax
801016a8:	e8 13 0e 00 00       	call   801024c0 <writei>
801016ad:	83 c4 10             	add    $0x10,%esp
801016b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
801016b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801016b7:	7e 11                	jle    801016ca <filewrite+0xdb>
        f->off += r;
801016b9:	8b 45 08             	mov    0x8(%ebp),%eax
801016bc:	8b 50 14             	mov    0x14(%eax),%edx
801016bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801016c2:	01 c2                	add    %eax,%edx
801016c4:	8b 45 08             	mov    0x8(%ebp),%eax
801016c7:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801016ca:	8b 45 08             	mov    0x8(%ebp),%eax
801016cd:	8b 40 10             	mov    0x10(%eax),%eax
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	50                   	push   %eax
801016d4:	e8 46 08 00 00       	call   80101f1f <iunlock>
801016d9:	83 c4 10             	add    $0x10,%esp
      end_op();
801016dc:	e8 33 26 00 00       	call   80103d14 <end_op>

      if(r < 0)
801016e1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801016e5:	78 2b                	js     80101712 <filewrite+0x123>
        break;
      if(r != n1)
801016e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801016ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801016ed:	74 0f                	je     801016fe <filewrite+0x10f>
        panic("short filewrite");
801016ef:	83 ec 0c             	sub    $0xc,%esp
801016f2:	8d 83 0e d0 ff ff    	lea    -0x2ff2(%ebx),%eax
801016f8:	50                   	push   %eax
801016f9:	e8 77 ef ff ff       	call   80100675 <panic>
      i += r;
801016fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101701:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
80101704:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101707:	3b 45 10             	cmp    0x10(%ebp),%eax
8010170a:	0f 8c 4f ff ff ff    	jl     8010165f <filewrite+0x70>
80101710:	eb 01                	jmp    80101713 <filewrite+0x124>
        break;
80101712:	90                   	nop
    }
    return i == n ? n : -1;
80101713:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101716:	3b 45 10             	cmp    0x10(%ebp),%eax
80101719:	75 05                	jne    80101720 <filewrite+0x131>
8010171b:	8b 45 10             	mov    0x10(%ebp),%eax
8010171e:	eb 16                	jmp    80101736 <filewrite+0x147>
80101720:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101725:	eb 0f                	jmp    80101736 <filewrite+0x147>
  }
  panic("filewrite");
80101727:	83 ec 0c             	sub    $0xc,%esp
8010172a:	8d 83 1e d0 ff ff    	lea    -0x2fe2(%ebx),%eax
80101730:	50                   	push   %eax
80101731:	e8 3f ef ff ff       	call   80100675 <panic>
}
80101736:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101739:	5b                   	pop    %ebx
8010173a:	5e                   	pop    %esi
8010173b:	5d                   	pop    %ebp
8010173c:	c3                   	ret    

8010173d <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010173d:	55                   	push   %ebp
8010173e:	89 e5                	mov    %esp,%ebp
80101740:	53                   	push   %ebx
80101741:	83 ec 14             	sub    $0x14,%esp
80101744:	e8 3c ec ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101749:	81 c3 77 ad 00 00    	add    $0xad77,%ebx
  struct buf *bp;

  bp = bread(dev, 1);
8010174f:	8b 45 08             	mov    0x8(%ebp),%eax
80101752:	83 ec 08             	sub    $0x8,%esp
80101755:	6a 01                	push   $0x1
80101757:	50                   	push   %eax
80101758:	e8 af ea ff ff       	call   8010020c <bread>
8010175d:	83 c4 10             	add    $0x10,%esp
80101760:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101763:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101766:	83 c0 5c             	add    $0x5c,%eax
80101769:	83 ec 04             	sub    $0x4,%esp
8010176c:	6a 1c                	push   $0x1c
8010176e:	50                   	push   %eax
8010176f:	ff 75 0c             	push   0xc(%ebp)
80101772:	e8 50 47 00 00       	call   80105ec7 <memmove>
80101777:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010177a:	83 ec 0c             	sub    $0xc,%esp
8010177d:	ff 75 f4             	push   -0xc(%ebp)
80101780:	e8 29 eb ff ff       	call   801002ae <brelse>
80101785:	83 c4 10             	add    $0x10,%esp
}
80101788:	90                   	nop
80101789:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010178c:	c9                   	leave  
8010178d:	c3                   	ret    

8010178e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010178e:	55                   	push   %ebp
8010178f:	89 e5                	mov    %esp,%ebp
80101791:	53                   	push   %ebx
80101792:	83 ec 14             	sub    $0x14,%esp
80101795:	e8 eb eb ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010179a:	81 c3 26 ad 00 00    	add    $0xad26,%ebx
  struct buf *bp;

  bp = bread(dev, bno);
801017a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801017a3:	8b 45 08             	mov    0x8(%ebp),%eax
801017a6:	83 ec 08             	sub    $0x8,%esp
801017a9:	52                   	push   %edx
801017aa:	50                   	push   %eax
801017ab:	e8 5c ea ff ff       	call   8010020c <bread>
801017b0:	83 c4 10             	add    $0x10,%esp
801017b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801017b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017b9:	83 c0 5c             	add    $0x5c,%eax
801017bc:	83 ec 04             	sub    $0x4,%esp
801017bf:	68 00 02 00 00       	push   $0x200
801017c4:	6a 00                	push   $0x0
801017c6:	50                   	push   %eax
801017c7:	e8 28 46 00 00       	call   80105df4 <memset>
801017cc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017cf:	83 ec 0c             	sub    $0xc,%esp
801017d2:	ff 75 f4             	push   -0xc(%ebp)
801017d5:	e8 2a 27 00 00       	call   80103f04 <log_write>
801017da:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017dd:	83 ec 0c             	sub    $0xc,%esp
801017e0:	ff 75 f4             	push   -0xc(%ebp)
801017e3:	e8 c6 ea ff ff       	call   801002ae <brelse>
801017e8:	83 c4 10             	add    $0x10,%esp
}
801017eb:	90                   	nop
801017ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017ef:	c9                   	leave  
801017f0:	c3                   	ret    

801017f1 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801017f1:	55                   	push   %ebp
801017f2:	89 e5                	mov    %esp,%ebp
801017f4:	53                   	push   %ebx
801017f5:	83 ec 14             	sub    $0x14,%esp
801017f8:	e8 88 eb ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801017fd:	81 c3 c3 ac 00 00    	add    $0xacc3,%ebx
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101803:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010180a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101811:	e9 0d 01 00 00       	jmp    80101923 <balloc+0x132>
    bp = bread(dev, BBLOCK(b, sb));
80101816:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101819:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010181f:	85 c0                	test   %eax,%eax
80101821:	0f 48 c2             	cmovs  %edx,%eax
80101824:	c1 f8 0c             	sar    $0xc,%eax
80101827:	89 c2                	mov    %eax,%edx
80101829:	8b 83 38 55 00 00    	mov    0x5538(%ebx),%eax
8010182f:	01 d0                	add    %edx,%eax
80101831:	83 ec 08             	sub    $0x8,%esp
80101834:	50                   	push   %eax
80101835:	ff 75 08             	push   0x8(%ebp)
80101838:	e8 cf e9 ff ff       	call   8010020c <bread>
8010183d:	83 c4 10             	add    $0x10,%esp
80101840:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101843:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010184a:	e9 9e 00 00 00       	jmp    801018ed <balloc+0xfc>
      m = 1 << (bi % 8);
8010184f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101852:	83 e0 07             	and    $0x7,%eax
80101855:	ba 01 00 00 00       	mov    $0x1,%edx
8010185a:	89 c1                	mov    %eax,%ecx
8010185c:	d3 e2                	shl    %cl,%edx
8010185e:	89 d0                	mov    %edx,%eax
80101860:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101863:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101866:	8d 50 07             	lea    0x7(%eax),%edx
80101869:	85 c0                	test   %eax,%eax
8010186b:	0f 48 c2             	cmovs  %edx,%eax
8010186e:	c1 f8 03             	sar    $0x3,%eax
80101871:	89 c2                	mov    %eax,%edx
80101873:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101876:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
8010187b:	0f b6 c0             	movzbl %al,%eax
8010187e:	23 45 e8             	and    -0x18(%ebp),%eax
80101881:	85 c0                	test   %eax,%eax
80101883:	75 64                	jne    801018e9 <balloc+0xf8>
        bp->data[bi/8] |= m;  // Mark block in use.
80101885:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101888:	8d 50 07             	lea    0x7(%eax),%edx
8010188b:	85 c0                	test   %eax,%eax
8010188d:	0f 48 c2             	cmovs  %edx,%eax
80101890:	c1 f8 03             	sar    $0x3,%eax
80101893:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101896:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
8010189b:	89 d1                	mov    %edx,%ecx
8010189d:	8b 55 e8             	mov    -0x18(%ebp),%edx
801018a0:	09 ca                	or     %ecx,%edx
801018a2:	89 d1                	mov    %edx,%ecx
801018a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801018a7:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
801018ab:	83 ec 0c             	sub    $0xc,%esp
801018ae:	ff 75 ec             	push   -0x14(%ebp)
801018b1:	e8 4e 26 00 00       	call   80103f04 <log_write>
801018b6:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801018b9:	83 ec 0c             	sub    $0xc,%esp
801018bc:	ff 75 ec             	push   -0x14(%ebp)
801018bf:	e8 ea e9 ff ff       	call   801002ae <brelse>
801018c4:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801018c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801018ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018cd:	01 c2                	add    %eax,%edx
801018cf:	8b 45 08             	mov    0x8(%ebp),%eax
801018d2:	83 ec 08             	sub    $0x8,%esp
801018d5:	52                   	push   %edx
801018d6:	50                   	push   %eax
801018d7:	e8 b2 fe ff ff       	call   8010178e <bzero>
801018dc:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801018df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801018e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018e5:	01 d0                	add    %edx,%eax
801018e7:	eb 5a                	jmp    80101943 <balloc+0x152>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801018e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801018ed:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801018f4:	7f 18                	jg     8010190e <balloc+0x11d>
801018f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801018f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018fc:	01 d0                	add    %edx,%eax
801018fe:	89 c2                	mov    %eax,%edx
80101900:	8b 83 20 55 00 00    	mov    0x5520(%ebx),%eax
80101906:	39 c2                	cmp    %eax,%edx
80101908:	0f 82 41 ff ff ff    	jb     8010184f <balloc+0x5e>
      }
    }
    brelse(bp);
8010190e:	83 ec 0c             	sub    $0xc,%esp
80101911:	ff 75 ec             	push   -0x14(%ebp)
80101914:	e8 95 e9 ff ff       	call   801002ae <brelse>
80101919:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
8010191c:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101923:	8b 93 20 55 00 00    	mov    0x5520(%ebx),%edx
80101929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010192c:	39 c2                	cmp    %eax,%edx
8010192e:	0f 87 e2 fe ff ff    	ja     80101816 <balloc+0x25>
  }
  panic("balloc: out of blocks");
80101934:	83 ec 0c             	sub    $0xc,%esp
80101937:	8d 83 28 d0 ff ff    	lea    -0x2fd8(%ebx),%eax
8010193d:	50                   	push   %eax
8010193e:	e8 32 ed ff ff       	call   80100675 <panic>
}
80101943:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101946:	c9                   	leave  
80101947:	c3                   	ret    

80101948 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101948:	55                   	push   %ebp
80101949:	89 e5                	mov    %esp,%ebp
8010194b:	53                   	push   %ebx
8010194c:	83 ec 14             	sub    $0x14,%esp
8010194f:	e8 31 ea ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101954:	81 c3 6c ab 00 00    	add    $0xab6c,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
8010195a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010195d:	c1 e8 0c             	shr    $0xc,%eax
80101960:	89 c2                	mov    %eax,%edx
80101962:	8b 83 38 55 00 00    	mov    0x5538(%ebx),%eax
80101968:	01 c2                	add    %eax,%edx
8010196a:	8b 45 08             	mov    0x8(%ebp),%eax
8010196d:	83 ec 08             	sub    $0x8,%esp
80101970:	52                   	push   %edx
80101971:	50                   	push   %eax
80101972:	e8 95 e8 ff ff       	call   8010020c <bread>
80101977:	83 c4 10             	add    $0x10,%esp
8010197a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010197d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101980:	25 ff 0f 00 00       	and    $0xfff,%eax
80101985:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101988:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010198b:	83 e0 07             	and    $0x7,%eax
8010198e:	ba 01 00 00 00       	mov    $0x1,%edx
80101993:	89 c1                	mov    %eax,%ecx
80101995:	d3 e2                	shl    %cl,%edx
80101997:	89 d0                	mov    %edx,%eax
80101999:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010199c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010199f:	8d 50 07             	lea    0x7(%eax),%edx
801019a2:	85 c0                	test   %eax,%eax
801019a4:	0f 48 c2             	cmovs  %edx,%eax
801019a7:	c1 f8 03             	sar    $0x3,%eax
801019aa:	89 c2                	mov    %eax,%edx
801019ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019af:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
801019b4:	0f b6 c0             	movzbl %al,%eax
801019b7:	23 45 ec             	and    -0x14(%ebp),%eax
801019ba:	85 c0                	test   %eax,%eax
801019bc:	75 0f                	jne    801019cd <bfree+0x85>
    panic("freeing free block");
801019be:	83 ec 0c             	sub    $0xc,%esp
801019c1:	8d 83 3e d0 ff ff    	lea    -0x2fc2(%ebx),%eax
801019c7:	50                   	push   %eax
801019c8:	e8 a8 ec ff ff       	call   80100675 <panic>
  bp->data[bi/8] &= ~m;
801019cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d0:	8d 50 07             	lea    0x7(%eax),%edx
801019d3:	85 c0                	test   %eax,%eax
801019d5:	0f 48 c2             	cmovs  %edx,%eax
801019d8:	c1 f8 03             	sar    $0x3,%eax
801019db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801019de:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
801019e3:	89 d1                	mov    %edx,%ecx
801019e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
801019e8:	f7 d2                	not    %edx
801019ea:	21 ca                	and    %ecx,%edx
801019ec:	89 d1                	mov    %edx,%ecx
801019ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
801019f1:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
801019f5:	83 ec 0c             	sub    $0xc,%esp
801019f8:	ff 75 f4             	push   -0xc(%ebp)
801019fb:	e8 04 25 00 00       	call   80103f04 <log_write>
80101a00:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101a03:	83 ec 0c             	sub    $0xc,%esp
80101a06:	ff 75 f4             	push   -0xc(%ebp)
80101a09:	e8 a0 e8 ff ff       	call   801002ae <brelse>
80101a0e:	83 c4 10             	add    $0x10,%esp
}
80101a11:	90                   	nop
80101a12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a15:	c9                   	leave  
80101a16:	c3                   	ret    

80101a17 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101a17:	55                   	push   %ebp
80101a18:	89 e5                	mov    %esp,%ebp
80101a1a:	57                   	push   %edi
80101a1b:	56                   	push   %esi
80101a1c:	53                   	push   %ebx
80101a1d:	83 ec 2c             	sub    $0x2c,%esp
80101a20:	e8 60 e9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101a25:	81 c3 9b aa 00 00    	add    $0xaa9b,%ebx
  int i = 0;
80101a2b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
80101a32:	83 ec 08             	sub    $0x8,%esp
80101a35:	8d 83 51 d0 ff ff    	lea    -0x2faf(%ebx),%eax
80101a3b:	50                   	push   %eax
80101a3c:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101a42:	50                   	push   %eax
80101a43:	e8 8e 40 00 00       	call   80105ad6 <initlock>
80101a48:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
80101a4b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a52:	eb 32                	jmp    80101a86 <iinit+0x6f>
    initsleeplock(&icache.inode[i].lock, "inode");
80101a54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a57:	89 d0                	mov    %edx,%eax
80101a59:	c1 e0 03             	shl    $0x3,%eax
80101a5c:	01 d0                	add    %edx,%eax
80101a5e:	c1 e0 04             	shl    $0x4,%eax
80101a61:	8d 50 30             	lea    0x30(%eax),%edx
80101a64:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101a6a:	01 d0                	add    %edx,%eax
80101a6c:	8d 50 10             	lea    0x10(%eax),%edx
80101a6f:	83 ec 08             	sub    $0x8,%esp
80101a72:	8d 83 58 d0 ff ff    	lea    -0x2fa8(%ebx),%eax
80101a78:	50                   	push   %eax
80101a79:	52                   	push   %edx
80101a7a:	e8 6e 3e 00 00       	call   801058ed <initsleeplock>
80101a7f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
80101a82:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101a86:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101a8a:	7e c8                	jle    80101a54 <iinit+0x3d>
  }

  readsb(dev, &sb);
80101a8c:	83 ec 08             	sub    $0x8,%esp
80101a8f:	8d 83 20 55 00 00    	lea    0x5520(%ebx),%eax
80101a95:	50                   	push   %eax
80101a96:	ff 75 08             	push   0x8(%ebp)
80101a99:	e8 9f fc ff ff       	call   8010173d <readsb>
80101a9e:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101aa1:	8b 93 38 55 00 00    	mov    0x5538(%ebx),%edx
80101aa7:	8b 83 34 55 00 00    	mov    0x5534(%ebx),%eax
80101aad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101ab0:	8b 8b 30 55 00 00    	mov    0x5530(%ebx),%ecx
80101ab6:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80101ab9:	8b bb 2c 55 00 00    	mov    0x552c(%ebx),%edi
80101abf:	8b b3 28 55 00 00    	mov    0x5528(%ebx),%esi
80101ac5:	8b 8b 24 55 00 00    	mov    0x5524(%ebx),%ecx
80101acb:	8b 83 20 55 00 00    	mov    0x5520(%ebx),%eax
80101ad1:	52                   	push   %edx
80101ad2:	ff 75 d4             	push   -0x2c(%ebp)
80101ad5:	ff 75 d0             	push   -0x30(%ebp)
80101ad8:	57                   	push   %edi
80101ad9:	56                   	push   %esi
80101ada:	51                   	push   %ecx
80101adb:	50                   	push   %eax
80101adc:	8d 83 60 d0 ff ff    	lea    -0x2fa0(%ebx),%eax
80101ae2:	50                   	push   %eax
80101ae3:	e8 c0 e9 ff ff       	call   801004a8 <cprintf>
80101ae8:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101aeb:	90                   	nop
80101aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aef:	5b                   	pop    %ebx
80101af0:	5e                   	pop    %esi
80101af1:	5f                   	pop    %edi
80101af2:	5d                   	pop    %ebp
80101af3:	c3                   	ret    

80101af4 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101af4:	55                   	push   %ebp
80101af5:	89 e5                	mov    %esp,%ebp
80101af7:	53                   	push   %ebx
80101af8:	83 ec 24             	sub    $0x24,%esp
80101afb:	e8 85 e8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101b00:	81 c3 c0 a9 00 00    	add    $0xa9c0,%ebx
80101b06:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b09:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101b0d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101b14:	e9 9f 00 00 00       	jmp    80101bb8 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum, sb));
80101b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b1c:	c1 e8 03             	shr    $0x3,%eax
80101b1f:	89 c2                	mov    %eax,%edx
80101b21:	8b 83 34 55 00 00    	mov    0x5534(%ebx),%eax
80101b27:	01 d0                	add    %edx,%eax
80101b29:	83 ec 08             	sub    $0x8,%esp
80101b2c:	50                   	push   %eax
80101b2d:	ff 75 08             	push   0x8(%ebp)
80101b30:	e8 d7 e6 ff ff       	call   8010020c <bread>
80101b35:	83 c4 10             	add    $0x10,%esp
80101b38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101b3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b3e:	8d 50 5c             	lea    0x5c(%eax),%edx
80101b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b44:	83 e0 07             	and    $0x7,%eax
80101b47:	c1 e0 06             	shl    $0x6,%eax
80101b4a:	01 d0                	add    %edx,%eax
80101b4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
80101b4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b52:	0f b7 00             	movzwl (%eax),%eax
80101b55:	66 85 c0             	test   %ax,%ax
80101b58:	75 4c                	jne    80101ba6 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
80101b5a:	83 ec 04             	sub    $0x4,%esp
80101b5d:	6a 40                	push   $0x40
80101b5f:	6a 00                	push   $0x0
80101b61:	ff 75 ec             	push   -0x14(%ebp)
80101b64:	e8 8b 42 00 00       	call   80105df4 <memset>
80101b69:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
80101b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b6f:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
80101b73:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101b76:	83 ec 0c             	sub    $0xc,%esp
80101b79:	ff 75 f0             	push   -0x10(%ebp)
80101b7c:	e8 83 23 00 00       	call   80103f04 <log_write>
80101b81:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101b84:	83 ec 0c             	sub    $0xc,%esp
80101b87:	ff 75 f0             	push   -0x10(%ebp)
80101b8a:	e8 1f e7 ff ff       	call   801002ae <brelse>
80101b8f:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b95:	83 ec 08             	sub    $0x8,%esp
80101b98:	50                   	push   %eax
80101b99:	ff 75 08             	push   0x8(%ebp)
80101b9c:	e8 0d 01 00 00       	call   80101cae <iget>
80101ba1:	83 c4 10             	add    $0x10,%esp
80101ba4:	eb 32                	jmp    80101bd8 <ialloc+0xe4>
    }
    brelse(bp);
80101ba6:	83 ec 0c             	sub    $0xc,%esp
80101ba9:	ff 75 f0             	push   -0x10(%ebp)
80101bac:	e8 fd e6 ff ff       	call   801002ae <brelse>
80101bb1:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101bb4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101bb8:	8b 93 28 55 00 00    	mov    0x5528(%ebx),%edx
80101bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bc1:	39 c2                	cmp    %eax,%edx
80101bc3:	0f 87 50 ff ff ff    	ja     80101b19 <ialloc+0x25>
  }
  panic("ialloc: no inodes");
80101bc9:	83 ec 0c             	sub    $0xc,%esp
80101bcc:	8d 83 b3 d0 ff ff    	lea    -0x2f4d(%ebx),%eax
80101bd2:	50                   	push   %eax
80101bd3:	e8 9d ea ff ff       	call   80100675 <panic>
}
80101bd8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bdb:	c9                   	leave  
80101bdc:	c3                   	ret    

80101bdd <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101bdd:	55                   	push   %ebp
80101bde:	89 e5                	mov    %esp,%ebp
80101be0:	53                   	push   %ebx
80101be1:	83 ec 14             	sub    $0x14,%esp
80101be4:	e8 9c e7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101be9:	81 c3 d7 a8 00 00    	add    $0xa8d7,%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101bef:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf2:	8b 40 04             	mov    0x4(%eax),%eax
80101bf5:	c1 e8 03             	shr    $0x3,%eax
80101bf8:	89 c2                	mov    %eax,%edx
80101bfa:	8b 83 34 55 00 00    	mov    0x5534(%ebx),%eax
80101c00:	01 c2                	add    %eax,%edx
80101c02:	8b 45 08             	mov    0x8(%ebp),%eax
80101c05:	8b 00                	mov    (%eax),%eax
80101c07:	83 ec 08             	sub    $0x8,%esp
80101c0a:	52                   	push   %edx
80101c0b:	50                   	push   %eax
80101c0c:	e8 fb e5 ff ff       	call   8010020c <bread>
80101c11:	83 c4 10             	add    $0x10,%esp
80101c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c1a:	8d 50 5c             	lea    0x5c(%eax),%edx
80101c1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c20:	8b 40 04             	mov    0x4(%eax),%eax
80101c23:	83 e0 07             	and    $0x7,%eax
80101c26:	c1 e0 06             	shl    $0x6,%eax
80101c29:	01 d0                	add    %edx,%eax
80101c2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101c2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c31:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c38:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101c3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3e:	0f b7 50 52          	movzwl 0x52(%eax),%edx
80101c42:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c45:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101c49:	8b 45 08             	mov    0x8(%ebp),%eax
80101c4c:	0f b7 50 54          	movzwl 0x54(%eax),%edx
80101c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c53:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101c57:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5a:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101c5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c61:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101c65:	8b 45 08             	mov    0x8(%ebp),%eax
80101c68:	8b 50 58             	mov    0x58(%eax),%edx
80101c6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c6e:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101c71:	8b 45 08             	mov    0x8(%ebp),%eax
80101c74:	8d 50 5c             	lea    0x5c(%eax),%edx
80101c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c7a:	83 c0 0c             	add    $0xc,%eax
80101c7d:	83 ec 04             	sub    $0x4,%esp
80101c80:	6a 34                	push   $0x34
80101c82:	52                   	push   %edx
80101c83:	50                   	push   %eax
80101c84:	e8 3e 42 00 00       	call   80105ec7 <memmove>
80101c89:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101c8c:	83 ec 0c             	sub    $0xc,%esp
80101c8f:	ff 75 f4             	push   -0xc(%ebp)
80101c92:	e8 6d 22 00 00       	call   80103f04 <log_write>
80101c97:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101c9a:	83 ec 0c             	sub    $0xc,%esp
80101c9d:	ff 75 f4             	push   -0xc(%ebp)
80101ca0:	e8 09 e6 ff ff       	call   801002ae <brelse>
80101ca5:	83 c4 10             	add    $0x10,%esp
}
80101ca8:	90                   	nop
80101ca9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cac:	c9                   	leave  
80101cad:	c3                   	ret    

80101cae <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101cae:	55                   	push   %ebp
80101caf:	89 e5                	mov    %esp,%ebp
80101cb1:	53                   	push   %ebx
80101cb2:	83 ec 14             	sub    $0x14,%esp
80101cb5:	e8 cb e6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101cba:	81 c3 06 a8 00 00    	add    $0xa806,%ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101cc0:	83 ec 0c             	sub    $0xc,%esp
80101cc3:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101cc9:	50                   	push   %eax
80101cca:	e8 33 3e 00 00       	call   80105b02 <acquire>
80101ccf:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101cd2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101cd9:	8d 83 74 55 00 00    	lea    0x5574(%ebx),%eax
80101cdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ce2:	eb 62                	jmp    80101d46 <iget+0x98>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ce7:	8b 40 08             	mov    0x8(%eax),%eax
80101cea:	85 c0                	test   %eax,%eax
80101cec:	7e 3b                	jle    80101d29 <iget+0x7b>
80101cee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cf1:	8b 00                	mov    (%eax),%eax
80101cf3:	39 45 08             	cmp    %eax,0x8(%ebp)
80101cf6:	75 31                	jne    80101d29 <iget+0x7b>
80101cf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cfb:	8b 40 04             	mov    0x4(%eax),%eax
80101cfe:	39 45 0c             	cmp    %eax,0xc(%ebp)
80101d01:	75 26                	jne    80101d29 <iget+0x7b>
      ip->ref++;
80101d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d06:	8b 40 08             	mov    0x8(%eax),%eax
80101d09:	8d 50 01             	lea    0x1(%eax),%edx
80101d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d0f:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101d12:	83 ec 0c             	sub    $0xc,%esp
80101d15:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101d1b:	50                   	push   %eax
80101d1c:	e8 5c 3e 00 00       	call   80105b7d <release>
80101d21:	83 c4 10             	add    $0x10,%esp
      return ip;
80101d24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d27:	eb 7d                	jmp    80101da6 <iget+0xf8>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101d29:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101d2d:	75 10                	jne    80101d3f <iget+0x91>
80101d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d32:	8b 40 08             	mov    0x8(%eax),%eax
80101d35:	85 c0                	test   %eax,%eax
80101d37:	75 06                	jne    80101d3f <iget+0x91>
      empty = ip;
80101d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101d3f:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80101d46:	8d 83 94 71 00 00    	lea    0x7194(%ebx),%eax
80101d4c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101d4f:	72 93                	jb     80101ce4 <iget+0x36>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101d51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101d55:	75 0f                	jne    80101d66 <iget+0xb8>
    panic("iget: no inodes");
80101d57:	83 ec 0c             	sub    $0xc,%esp
80101d5a:	8d 83 c5 d0 ff ff    	lea    -0x2f3b(%ebx),%eax
80101d60:	50                   	push   %eax
80101d61:	e8 0f e9 ff ff       	call   80100675 <panic>

  ip = empty;
80101d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d6f:	8b 55 08             	mov    0x8(%ebp),%edx
80101d72:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101d74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d77:	8b 55 0c             	mov    0xc(%ebp),%edx
80101d7a:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101d7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d80:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
80101d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d8a:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
80101d91:	83 ec 0c             	sub    $0xc,%esp
80101d94:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101d9a:	50                   	push   %eax
80101d9b:	e8 dd 3d 00 00       	call   80105b7d <release>
80101da0:	83 c4 10             	add    $0x10,%esp

  return ip;
80101da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101da6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101da9:	c9                   	leave  
80101daa:	c3                   	ret    

80101dab <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101dab:	55                   	push   %ebp
80101dac:	89 e5                	mov    %esp,%ebp
80101dae:	53                   	push   %ebx
80101daf:	83 ec 04             	sub    $0x4,%esp
80101db2:	e8 ce e5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101db7:	81 c3 09 a7 00 00    	add    $0xa709,%ebx
  acquire(&icache.lock);
80101dbd:	83 ec 0c             	sub    $0xc,%esp
80101dc0:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101dc6:	50                   	push   %eax
80101dc7:	e8 36 3d 00 00       	call   80105b02 <acquire>
80101dcc:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101dcf:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd2:	8b 40 08             	mov    0x8(%eax),%eax
80101dd5:	8d 50 01             	lea    0x1(%eax),%edx
80101dd8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddb:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101dde:	83 ec 0c             	sub    $0xc,%esp
80101de1:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101de7:	50                   	push   %eax
80101de8:	e8 90 3d 00 00       	call   80105b7d <release>
80101ded:	83 c4 10             	add    $0x10,%esp
  return ip;
80101df0:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101df3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101df6:	c9                   	leave  
80101df7:	c3                   	ret    

80101df8 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101df8:	55                   	push   %ebp
80101df9:	89 e5                	mov    %esp,%ebp
80101dfb:	53                   	push   %ebx
80101dfc:	83 ec 14             	sub    $0x14,%esp
80101dff:	e8 81 e5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101e04:	81 c3 bc a6 00 00    	add    $0xa6bc,%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101e0a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101e0e:	74 0a                	je     80101e1a <ilock+0x22>
80101e10:	8b 45 08             	mov    0x8(%ebp),%eax
80101e13:	8b 40 08             	mov    0x8(%eax),%eax
80101e16:	85 c0                	test   %eax,%eax
80101e18:	7f 0f                	jg     80101e29 <ilock+0x31>
    panic("ilock");
80101e1a:	83 ec 0c             	sub    $0xc,%esp
80101e1d:	8d 83 d5 d0 ff ff    	lea    -0x2f2b(%ebx),%eax
80101e23:	50                   	push   %eax
80101e24:	e8 4c e8 ff ff       	call   80100675 <panic>

  acquiresleep(&ip->lock);
80101e29:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2c:	83 c0 0c             	add    $0xc,%eax
80101e2f:	83 ec 0c             	sub    $0xc,%esp
80101e32:	50                   	push   %eax
80101e33:	e8 03 3b 00 00       	call   8010593b <acquiresleep>
80101e38:	83 c4 10             	add    $0x10,%esp

  if(ip->valid == 0){
80101e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3e:	8b 40 4c             	mov    0x4c(%eax),%eax
80101e41:	85 c0                	test   %eax,%eax
80101e43:	0f 85 d0 00 00 00    	jne    80101f19 <ilock+0x121>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101e49:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4c:	8b 40 04             	mov    0x4(%eax),%eax
80101e4f:	c1 e8 03             	shr    $0x3,%eax
80101e52:	89 c2                	mov    %eax,%edx
80101e54:	8b 83 34 55 00 00    	mov    0x5534(%ebx),%eax
80101e5a:	01 c2                	add    %eax,%edx
80101e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5f:	8b 00                	mov    (%eax),%eax
80101e61:	83 ec 08             	sub    $0x8,%esp
80101e64:	52                   	push   %edx
80101e65:	50                   	push   %eax
80101e66:	e8 a1 e3 ff ff       	call   8010020c <bread>
80101e6b:	83 c4 10             	add    $0x10,%esp
80101e6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e74:	8d 50 5c             	lea    0x5c(%eax),%edx
80101e77:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7a:	8b 40 04             	mov    0x4(%eax),%eax
80101e7d:	83 e0 07             	and    $0x7,%eax
80101e80:	c1 e0 06             	shl    $0x6,%eax
80101e83:	01 d0                	add    %edx,%eax
80101e85:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101e88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e8b:	0f b7 10             	movzwl (%eax),%edx
80101e8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e91:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101e95:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e98:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101e9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9f:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ea6:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ead:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101eb4:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101eb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebb:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ec2:	8b 50 08             	mov    0x8(%eax),%edx
80101ec5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec8:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ecb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ece:	8d 50 0c             	lea    0xc(%eax),%edx
80101ed1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed4:	83 c0 5c             	add    $0x5c,%eax
80101ed7:	83 ec 04             	sub    $0x4,%esp
80101eda:	6a 34                	push   $0x34
80101edc:	52                   	push   %edx
80101edd:	50                   	push   %eax
80101ede:	e8 e4 3f 00 00       	call   80105ec7 <memmove>
80101ee3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101ee6:	83 ec 0c             	sub    $0xc,%esp
80101ee9:	ff 75 f4             	push   -0xc(%ebp)
80101eec:	e8 bd e3 ff ff       	call   801002ae <brelse>
80101ef1:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
80101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef7:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
    if(ip->type == 0)
80101efe:	8b 45 08             	mov    0x8(%ebp),%eax
80101f01:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101f05:	66 85 c0             	test   %ax,%ax
80101f08:	75 0f                	jne    80101f19 <ilock+0x121>
      panic("ilock: no type");
80101f0a:	83 ec 0c             	sub    $0xc,%esp
80101f0d:	8d 83 db d0 ff ff    	lea    -0x2f25(%ebx),%eax
80101f13:	50                   	push   %eax
80101f14:	e8 5c e7 ff ff       	call   80100675 <panic>
  }
}
80101f19:	90                   	nop
80101f1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f1d:	c9                   	leave  
80101f1e:	c3                   	ret    

80101f1f <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101f1f:	55                   	push   %ebp
80101f20:	89 e5                	mov    %esp,%ebp
80101f22:	53                   	push   %ebx
80101f23:	83 ec 04             	sub    $0x4,%esp
80101f26:	e8 5a e4 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101f2b:	81 c3 95 a5 00 00    	add    $0xa595,%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f31:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101f35:	74 20                	je     80101f57 <iunlock+0x38>
80101f37:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3a:	83 c0 0c             	add    $0xc,%eax
80101f3d:	83 ec 0c             	sub    $0xc,%esp
80101f40:	50                   	push   %eax
80101f41:	e8 c5 3a 00 00       	call   80105a0b <holdingsleep>
80101f46:	83 c4 10             	add    $0x10,%esp
80101f49:	85 c0                	test   %eax,%eax
80101f4b:	74 0a                	je     80101f57 <iunlock+0x38>
80101f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f50:	8b 40 08             	mov    0x8(%eax),%eax
80101f53:	85 c0                	test   %eax,%eax
80101f55:	7f 0f                	jg     80101f66 <iunlock+0x47>
    panic("iunlock");
80101f57:	83 ec 0c             	sub    $0xc,%esp
80101f5a:	8d 83 ea d0 ff ff    	lea    -0x2f16(%ebx),%eax
80101f60:	50                   	push   %eax
80101f61:	e8 0f e7 ff ff       	call   80100675 <panic>

  releasesleep(&ip->lock);
80101f66:	8b 45 08             	mov    0x8(%ebp),%eax
80101f69:	83 c0 0c             	add    $0xc,%eax
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	50                   	push   %eax
80101f70:	e8 39 3a 00 00       	call   801059ae <releasesleep>
80101f75:	83 c4 10             	add    $0x10,%esp
}
80101f78:	90                   	nop
80101f79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101f7c:	c9                   	leave  
80101f7d:	c3                   	ret    

80101f7e <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101f7e:	55                   	push   %ebp
80101f7f:	89 e5                	mov    %esp,%ebp
80101f81:	53                   	push   %ebx
80101f82:	83 ec 14             	sub    $0x14,%esp
80101f85:	e8 fb e3 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80101f8a:	81 c3 36 a5 00 00    	add    $0xa536,%ebx
  acquiresleep(&ip->lock);
80101f90:	8b 45 08             	mov    0x8(%ebp),%eax
80101f93:	83 c0 0c             	add    $0xc,%eax
80101f96:	83 ec 0c             	sub    $0xc,%esp
80101f99:	50                   	push   %eax
80101f9a:	e8 9c 39 00 00       	call   8010593b <acquiresleep>
80101f9f:	83 c4 10             	add    $0x10,%esp
  if(ip->valid && ip->nlink == 0){
80101fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa5:	8b 40 4c             	mov    0x4c(%eax),%eax
80101fa8:	85 c0                	test   %eax,%eax
80101faa:	74 6e                	je     8010201a <iput+0x9c>
80101fac:	8b 45 08             	mov    0x8(%ebp),%eax
80101faf:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101fb3:	66 85 c0             	test   %ax,%ax
80101fb6:	75 62                	jne    8010201a <iput+0x9c>
    acquire(&icache.lock);
80101fb8:	83 ec 0c             	sub    $0xc,%esp
80101fbb:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101fc1:	50                   	push   %eax
80101fc2:	e8 3b 3b 00 00       	call   80105b02 <acquire>
80101fc7:	83 c4 10             	add    $0x10,%esp
    int r = ip->ref;
80101fca:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcd:	8b 40 08             	mov    0x8(%eax),%eax
80101fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&icache.lock);
80101fd3:	83 ec 0c             	sub    $0xc,%esp
80101fd6:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80101fdc:	50                   	push   %eax
80101fdd:	e8 9b 3b 00 00       	call   80105b7d <release>
80101fe2:	83 c4 10             	add    $0x10,%esp
    if(r == 1){
80101fe5:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80101fe9:	75 2f                	jne    8010201a <iput+0x9c>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
80101feb:	83 ec 0c             	sub    $0xc,%esp
80101fee:	ff 75 08             	push   0x8(%ebp)
80101ff1:	e8 cf 01 00 00       	call   801021c5 <itrunc>
80101ff6:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
80101ff9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffc:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
      iupdate(ip);
80102002:	83 ec 0c             	sub    $0xc,%esp
80102005:	ff 75 08             	push   0x8(%ebp)
80102008:	e8 d0 fb ff ff       	call   80101bdd <iupdate>
8010200d:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
80102010:	8b 45 08             	mov    0x8(%ebp),%eax
80102013:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
    }
  }
  releasesleep(&ip->lock);
8010201a:	8b 45 08             	mov    0x8(%ebp),%eax
8010201d:	83 c0 0c             	add    $0xc,%eax
80102020:	83 ec 0c             	sub    $0xc,%esp
80102023:	50                   	push   %eax
80102024:	e8 85 39 00 00       	call   801059ae <releasesleep>
80102029:	83 c4 10             	add    $0x10,%esp

  acquire(&icache.lock);
8010202c:	83 ec 0c             	sub    $0xc,%esp
8010202f:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80102035:	50                   	push   %eax
80102036:	e8 c7 3a 00 00       	call   80105b02 <acquire>
8010203b:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
8010203e:	8b 45 08             	mov    0x8(%ebp),%eax
80102041:	8b 40 08             	mov    0x8(%eax),%eax
80102044:	8d 50 ff             	lea    -0x1(%eax),%edx
80102047:	8b 45 08             	mov    0x8(%ebp),%eax
8010204a:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
8010204d:	83 ec 0c             	sub    $0xc,%esp
80102050:	8d 83 40 55 00 00    	lea    0x5540(%ebx),%eax
80102056:	50                   	push   %eax
80102057:	e8 21 3b 00 00       	call   80105b7d <release>
8010205c:	83 c4 10             	add    $0x10,%esp
}
8010205f:	90                   	nop
80102060:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102063:	c9                   	leave  
80102064:	c3                   	ret    

80102065 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80102065:	55                   	push   %ebp
80102066:	89 e5                	mov    %esp,%ebp
80102068:	83 ec 08             	sub    $0x8,%esp
8010206b:	e8 b8 ec ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102070:	05 50 a4 00 00       	add    $0xa450,%eax
  iunlock(ip);
80102075:	83 ec 0c             	sub    $0xc,%esp
80102078:	ff 75 08             	push   0x8(%ebp)
8010207b:	e8 9f fe ff ff       	call   80101f1f <iunlock>
80102080:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80102083:	83 ec 0c             	sub    $0xc,%esp
80102086:	ff 75 08             	push   0x8(%ebp)
80102089:	e8 f0 fe ff ff       	call   80101f7e <iput>
8010208e:	83 c4 10             	add    $0x10,%esp
}
80102091:	90                   	nop
80102092:	c9                   	leave  
80102093:	c3                   	ret    

80102094 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102094:	55                   	push   %ebp
80102095:	89 e5                	mov    %esp,%ebp
80102097:	53                   	push   %ebx
80102098:	83 ec 14             	sub    $0x14,%esp
8010209b:	e8 e5 e2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801020a0:	81 c3 20 a4 00 00    	add    $0xa420,%ebx
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801020a6:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
801020aa:	77 42                	ja     801020ee <bmap+0x5a>
    if((addr = ip->addrs[bn]) == 0)
801020ac:	8b 45 08             	mov    0x8(%ebp),%eax
801020af:	8b 55 0c             	mov    0xc(%ebp),%edx
801020b2:	83 c2 14             	add    $0x14,%edx
801020b5:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801020b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801020bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801020c0:	75 24                	jne    801020e6 <bmap+0x52>
      ip->addrs[bn] = addr = balloc(ip->dev);
801020c2:	8b 45 08             	mov    0x8(%ebp),%eax
801020c5:	8b 00                	mov    (%eax),%eax
801020c7:	83 ec 0c             	sub    $0xc,%esp
801020ca:	50                   	push   %eax
801020cb:	e8 21 f7 ff ff       	call   801017f1 <balloc>
801020d0:	83 c4 10             	add    $0x10,%esp
801020d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801020d6:	8b 45 08             	mov    0x8(%ebp),%eax
801020d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801020dc:	8d 4a 14             	lea    0x14(%edx),%ecx
801020df:	8b 55 f4             	mov    -0xc(%ebp),%edx
801020e2:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
801020e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020e9:	e9 d2 00 00 00       	jmp    801021c0 <bmap+0x12c>
  }
  bn -= NDIRECT;
801020ee:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
801020f2:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
801020f6:	0f 87 b5 00 00 00    	ja     801021b1 <bmap+0x11d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801020fc:	8b 45 08             	mov    0x8(%ebp),%eax
801020ff:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102105:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102108:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010210c:	75 20                	jne    8010212e <bmap+0x9a>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
8010210e:	8b 45 08             	mov    0x8(%ebp),%eax
80102111:	8b 00                	mov    (%eax),%eax
80102113:	83 ec 0c             	sub    $0xc,%esp
80102116:	50                   	push   %eax
80102117:	e8 d5 f6 ff ff       	call   801017f1 <balloc>
8010211c:	83 c4 10             	add    $0x10,%esp
8010211f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102122:	8b 45 08             	mov    0x8(%ebp),%eax
80102125:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102128:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
8010212e:	8b 45 08             	mov    0x8(%ebp),%eax
80102131:	8b 00                	mov    (%eax),%eax
80102133:	83 ec 08             	sub    $0x8,%esp
80102136:	ff 75 f4             	push   -0xc(%ebp)
80102139:	50                   	push   %eax
8010213a:	e8 cd e0 ff ff       	call   8010020c <bread>
8010213f:	83 c4 10             	add    $0x10,%esp
80102142:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80102145:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102148:	83 c0 5c             	add    $0x5c,%eax
8010214b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
8010214e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102151:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80102158:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010215b:	01 d0                	add    %edx,%eax
8010215d:	8b 00                	mov    (%eax),%eax
8010215f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102162:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102166:	75 36                	jne    8010219e <bmap+0x10a>
      a[bn] = addr = balloc(ip->dev);
80102168:	8b 45 08             	mov    0x8(%ebp),%eax
8010216b:	8b 00                	mov    (%eax),%eax
8010216d:	83 ec 0c             	sub    $0xc,%esp
80102170:	50                   	push   %eax
80102171:	e8 7b f6 ff ff       	call   801017f1 <balloc>
80102176:	83 c4 10             	add    $0x10,%esp
80102179:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010217c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010217f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80102186:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102189:	01 c2                	add    %eax,%edx
8010218b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010218e:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80102190:	83 ec 0c             	sub    $0xc,%esp
80102193:	ff 75 f0             	push   -0x10(%ebp)
80102196:	e8 69 1d 00 00       	call   80103f04 <log_write>
8010219b:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
8010219e:	83 ec 0c             	sub    $0xc,%esp
801021a1:	ff 75 f0             	push   -0x10(%ebp)
801021a4:	e8 05 e1 ff ff       	call   801002ae <brelse>
801021a9:	83 c4 10             	add    $0x10,%esp
    return addr;
801021ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021af:	eb 0f                	jmp    801021c0 <bmap+0x12c>
  }

  panic("bmap: out of range");
801021b1:	83 ec 0c             	sub    $0xc,%esp
801021b4:	8d 83 f2 d0 ff ff    	lea    -0x2f0e(%ebx),%eax
801021ba:	50                   	push   %eax
801021bb:	e8 b5 e4 ff ff       	call   80100675 <panic>
}
801021c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021c3:	c9                   	leave  
801021c4:	c3                   	ret    

801021c5 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
801021c5:	55                   	push   %ebp
801021c6:	89 e5                	mov    %esp,%ebp
801021c8:	53                   	push   %ebx
801021c9:	83 ec 14             	sub    $0x14,%esp
801021cc:	e8 b4 e1 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801021d1:	81 c3 ef a2 00 00    	add    $0xa2ef,%ebx
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801021d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801021de:	eb 45                	jmp    80102225 <itrunc+0x60>
    if(ip->addrs[i]){
801021e0:	8b 45 08             	mov    0x8(%ebp),%eax
801021e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021e6:	83 c2 14             	add    $0x14,%edx
801021e9:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801021ed:	85 c0                	test   %eax,%eax
801021ef:	74 30                	je     80102221 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
801021f1:	8b 45 08             	mov    0x8(%ebp),%eax
801021f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021f7:	83 c2 14             	add    $0x14,%edx
801021fa:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801021fe:	8b 55 08             	mov    0x8(%ebp),%edx
80102201:	8b 12                	mov    (%edx),%edx
80102203:	83 ec 08             	sub    $0x8,%esp
80102206:	50                   	push   %eax
80102207:	52                   	push   %edx
80102208:	e8 3b f7 ff ff       	call   80101948 <bfree>
8010220d:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80102210:	8b 45 08             	mov    0x8(%ebp),%eax
80102213:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102216:	83 c2 14             	add    $0x14,%edx
80102219:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80102220:	00 
  for(i = 0; i < NDIRECT; i++){
80102221:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102225:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80102229:	7e b5                	jle    801021e0 <itrunc+0x1b>
    }
  }

  if(ip->addrs[NDIRECT]){
8010222b:	8b 45 08             	mov    0x8(%ebp),%eax
8010222e:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102234:	85 c0                	test   %eax,%eax
80102236:	0f 84 aa 00 00 00    	je     801022e6 <itrunc+0x121>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010223c:	8b 45 08             	mov    0x8(%ebp),%eax
8010223f:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80102245:	8b 45 08             	mov    0x8(%ebp),%eax
80102248:	8b 00                	mov    (%eax),%eax
8010224a:	83 ec 08             	sub    $0x8,%esp
8010224d:	52                   	push   %edx
8010224e:	50                   	push   %eax
8010224f:	e8 b8 df ff ff       	call   8010020c <bread>
80102254:	83 c4 10             	add    $0x10,%esp
80102257:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
8010225a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010225d:	83 c0 5c             	add    $0x5c,%eax
80102260:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102263:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010226a:	eb 3c                	jmp    801022a8 <itrunc+0xe3>
      if(a[j])
8010226c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010226f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80102276:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102279:	01 d0                	add    %edx,%eax
8010227b:	8b 00                	mov    (%eax),%eax
8010227d:	85 c0                	test   %eax,%eax
8010227f:	74 23                	je     801022a4 <itrunc+0xdf>
        bfree(ip->dev, a[j]);
80102281:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102284:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010228b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010228e:	01 d0                	add    %edx,%eax
80102290:	8b 00                	mov    (%eax),%eax
80102292:	8b 55 08             	mov    0x8(%ebp),%edx
80102295:	8b 12                	mov    (%edx),%edx
80102297:	83 ec 08             	sub    $0x8,%esp
8010229a:	50                   	push   %eax
8010229b:	52                   	push   %edx
8010229c:	e8 a7 f6 ff ff       	call   80101948 <bfree>
801022a1:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
801022a4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801022a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022ab:	83 f8 7f             	cmp    $0x7f,%eax
801022ae:	76 bc                	jbe    8010226c <itrunc+0xa7>
    }
    brelse(bp);
801022b0:	83 ec 0c             	sub    $0xc,%esp
801022b3:	ff 75 ec             	push   -0x14(%ebp)
801022b6:	e8 f3 df ff ff       	call   801002ae <brelse>
801022bb:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
801022be:	8b 45 08             	mov    0x8(%ebp),%eax
801022c1:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801022c7:	8b 55 08             	mov    0x8(%ebp),%edx
801022ca:	8b 12                	mov    (%edx),%edx
801022cc:	83 ec 08             	sub    $0x8,%esp
801022cf:	50                   	push   %eax
801022d0:	52                   	push   %edx
801022d1:	e8 72 f6 ff ff       	call   80101948 <bfree>
801022d6:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
801022d9:	8b 45 08             	mov    0x8(%ebp),%eax
801022dc:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
801022e3:	00 00 00 
  }

  ip->size = 0;
801022e6:	8b 45 08             	mov    0x8(%ebp),%eax
801022e9:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	ff 75 08             	push   0x8(%ebp)
801022f6:	e8 e2 f8 ff ff       	call   80101bdd <iupdate>
801022fb:	83 c4 10             	add    $0x10,%esp
}
801022fe:	90                   	nop
801022ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102302:	c9                   	leave  
80102303:	c3                   	ret    

80102304 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102304:	55                   	push   %ebp
80102305:	89 e5                	mov    %esp,%ebp
80102307:	e8 1c ea ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010230c:	05 b4 a1 00 00       	add    $0xa1b4,%eax
  st->dev = ip->dev;
80102311:	8b 45 08             	mov    0x8(%ebp),%eax
80102314:	8b 00                	mov    (%eax),%eax
80102316:	89 c2                	mov    %eax,%edx
80102318:	8b 45 0c             	mov    0xc(%ebp),%eax
8010231b:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
8010231e:	8b 45 08             	mov    0x8(%ebp),%eax
80102321:	8b 50 04             	mov    0x4(%eax),%edx
80102324:	8b 45 0c             	mov    0xc(%ebp),%eax
80102327:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
8010232a:	8b 45 08             	mov    0x8(%ebp),%eax
8010232d:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80102331:	8b 45 0c             	mov    0xc(%ebp),%eax
80102334:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80102337:	8b 45 08             	mov    0x8(%ebp),%eax
8010233a:	0f b7 50 56          	movzwl 0x56(%eax),%edx
8010233e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102341:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80102345:	8b 45 08             	mov    0x8(%ebp),%eax
80102348:	8b 50 58             	mov    0x58(%eax),%edx
8010234b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010234e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102351:	90                   	nop
80102352:	5d                   	pop    %ebp
80102353:	c3                   	ret    

80102354 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102354:	55                   	push   %ebp
80102355:	89 e5                	mov    %esp,%ebp
80102357:	53                   	push   %ebx
80102358:	83 ec 14             	sub    $0x14,%esp
8010235b:	e8 25 e0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102360:	81 c3 60 a1 00 00    	add    $0xa160,%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102366:	8b 45 08             	mov    0x8(%ebp),%eax
80102369:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010236d:	66 83 f8 03          	cmp    $0x3,%ax
80102371:	75 64                	jne    801023d7 <readi+0x83>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102373:	8b 45 08             	mov    0x8(%ebp),%eax
80102376:	0f b7 40 52          	movzwl 0x52(%eax),%eax
8010237a:	66 85 c0             	test   %ax,%ax
8010237d:	78 24                	js     801023a3 <readi+0x4f>
8010237f:	8b 45 08             	mov    0x8(%ebp),%eax
80102382:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102386:	66 83 f8 09          	cmp    $0x9,%ax
8010238a:	7f 17                	jg     801023a3 <readi+0x4f>
8010238c:	8b 45 08             	mov    0x8(%ebp),%eax
8010238f:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102393:	0f bf d0             	movswl %ax,%edx
80102396:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
8010239c:	8b 04 d0             	mov    (%eax,%edx,8),%eax
8010239f:	85 c0                	test   %eax,%eax
801023a1:	75 0a                	jne    801023ad <readi+0x59>
      return -1;
801023a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023a8:	e9 0e 01 00 00       	jmp    801024bb <readi+0x167>
    return devsw[ip->major].read(ip, dst, n);
801023ad:	8b 45 08             	mov    0x8(%ebp),%eax
801023b0:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801023b4:	0f bf d0             	movswl %ax,%edx
801023b7:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
801023bd:	8b 04 d0             	mov    (%eax,%edx,8),%eax
801023c0:	8b 55 14             	mov    0x14(%ebp),%edx
801023c3:	83 ec 04             	sub    $0x4,%esp
801023c6:	52                   	push   %edx
801023c7:	ff 75 0c             	push   0xc(%ebp)
801023ca:	ff 75 08             	push   0x8(%ebp)
801023cd:	ff d0                	call   *%eax
801023cf:	83 c4 10             	add    $0x10,%esp
801023d2:	e9 e4 00 00 00       	jmp    801024bb <readi+0x167>
  }

  if(off > ip->size || off + n < off)
801023d7:	8b 45 08             	mov    0x8(%ebp),%eax
801023da:	8b 40 58             	mov    0x58(%eax),%eax
801023dd:	39 45 10             	cmp    %eax,0x10(%ebp)
801023e0:	77 0d                	ja     801023ef <readi+0x9b>
801023e2:	8b 55 10             	mov    0x10(%ebp),%edx
801023e5:	8b 45 14             	mov    0x14(%ebp),%eax
801023e8:	01 d0                	add    %edx,%eax
801023ea:	39 45 10             	cmp    %eax,0x10(%ebp)
801023ed:	76 0a                	jbe    801023f9 <readi+0xa5>
    return -1;
801023ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023f4:	e9 c2 00 00 00       	jmp    801024bb <readi+0x167>
  if(off + n > ip->size)
801023f9:	8b 55 10             	mov    0x10(%ebp),%edx
801023fc:	8b 45 14             	mov    0x14(%ebp),%eax
801023ff:	01 c2                	add    %eax,%edx
80102401:	8b 45 08             	mov    0x8(%ebp),%eax
80102404:	8b 40 58             	mov    0x58(%eax),%eax
80102407:	39 c2                	cmp    %eax,%edx
80102409:	76 0c                	jbe    80102417 <readi+0xc3>
    n = ip->size - off;
8010240b:	8b 45 08             	mov    0x8(%ebp),%eax
8010240e:	8b 40 58             	mov    0x58(%eax),%eax
80102411:	2b 45 10             	sub    0x10(%ebp),%eax
80102414:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102417:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010241e:	e9 89 00 00 00       	jmp    801024ac <readi+0x158>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102423:	8b 45 10             	mov    0x10(%ebp),%eax
80102426:	c1 e8 09             	shr    $0x9,%eax
80102429:	83 ec 08             	sub    $0x8,%esp
8010242c:	50                   	push   %eax
8010242d:	ff 75 08             	push   0x8(%ebp)
80102430:	e8 5f fc ff ff       	call   80102094 <bmap>
80102435:	83 c4 10             	add    $0x10,%esp
80102438:	8b 55 08             	mov    0x8(%ebp),%edx
8010243b:	8b 12                	mov    (%edx),%edx
8010243d:	83 ec 08             	sub    $0x8,%esp
80102440:	50                   	push   %eax
80102441:	52                   	push   %edx
80102442:	e8 c5 dd ff ff       	call   8010020c <bread>
80102447:	83 c4 10             	add    $0x10,%esp
8010244a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010244d:	8b 45 10             	mov    0x10(%ebp),%eax
80102450:	25 ff 01 00 00       	and    $0x1ff,%eax
80102455:	ba 00 02 00 00       	mov    $0x200,%edx
8010245a:	29 c2                	sub    %eax,%edx
8010245c:	8b 45 14             	mov    0x14(%ebp),%eax
8010245f:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102462:	39 c2                	cmp    %eax,%edx
80102464:	0f 46 c2             	cmovbe %edx,%eax
80102467:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
8010246a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010246d:	8d 50 5c             	lea    0x5c(%eax),%edx
80102470:	8b 45 10             	mov    0x10(%ebp),%eax
80102473:	25 ff 01 00 00       	and    $0x1ff,%eax
80102478:	01 d0                	add    %edx,%eax
8010247a:	83 ec 04             	sub    $0x4,%esp
8010247d:	ff 75 ec             	push   -0x14(%ebp)
80102480:	50                   	push   %eax
80102481:	ff 75 0c             	push   0xc(%ebp)
80102484:	e8 3e 3a 00 00       	call   80105ec7 <memmove>
80102489:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010248c:	83 ec 0c             	sub    $0xc,%esp
8010248f:	ff 75 f0             	push   -0x10(%ebp)
80102492:	e8 17 de ff ff       	call   801002ae <brelse>
80102497:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010249a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010249d:	01 45 f4             	add    %eax,-0xc(%ebp)
801024a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024a3:	01 45 10             	add    %eax,0x10(%ebp)
801024a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024a9:	01 45 0c             	add    %eax,0xc(%ebp)
801024ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024af:	3b 45 14             	cmp    0x14(%ebp),%eax
801024b2:	0f 82 6b ff ff ff    	jb     80102423 <readi+0xcf>
  }
  return n;
801024b8:	8b 45 14             	mov    0x14(%ebp),%eax
}
801024bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024be:	c9                   	leave  
801024bf:	c3                   	ret    

801024c0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	53                   	push   %ebx
801024c4:	83 ec 14             	sub    $0x14,%esp
801024c7:	e8 b9 de ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801024cc:	81 c3 f4 9f 00 00    	add    $0x9ff4,%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801024d2:	8b 45 08             	mov    0x8(%ebp),%eax
801024d5:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801024d9:	66 83 f8 03          	cmp    $0x3,%ax
801024dd:	75 66                	jne    80102545 <writei+0x85>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801024df:	8b 45 08             	mov    0x8(%ebp),%eax
801024e2:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801024e6:	66 85 c0             	test   %ax,%ax
801024e9:	78 25                	js     80102510 <writei+0x50>
801024eb:	8b 45 08             	mov    0x8(%ebp),%eax
801024ee:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801024f2:	66 83 f8 09          	cmp    $0x9,%ax
801024f6:	7f 18                	jg     80102510 <writei+0x50>
801024f8:	8b 45 08             	mov    0x8(%ebp),%eax
801024fb:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801024ff:	0f bf d0             	movswl %ax,%edx
80102502:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
80102508:	8b 44 d0 04          	mov    0x4(%eax,%edx,8),%eax
8010250c:	85 c0                	test   %eax,%eax
8010250e:	75 0a                	jne    8010251a <writei+0x5a>
      return -1;
80102510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102515:	e9 40 01 00 00       	jmp    8010265a <writei+0x19a>
    return devsw[ip->major].write(ip, src, n);
8010251a:	8b 45 08             	mov    0x8(%ebp),%eax
8010251d:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102521:	0f bf d0             	movswl %ax,%edx
80102524:	c7 c0 e0 0f 11 80    	mov    $0x80110fe0,%eax
8010252a:	8b 44 d0 04          	mov    0x4(%eax,%edx,8),%eax
8010252e:	8b 55 14             	mov    0x14(%ebp),%edx
80102531:	83 ec 04             	sub    $0x4,%esp
80102534:	52                   	push   %edx
80102535:	ff 75 0c             	push   0xc(%ebp)
80102538:	ff 75 08             	push   0x8(%ebp)
8010253b:	ff d0                	call   *%eax
8010253d:	83 c4 10             	add    $0x10,%esp
80102540:	e9 15 01 00 00       	jmp    8010265a <writei+0x19a>
  }

  if(off > ip->size || off + n < off)
80102545:	8b 45 08             	mov    0x8(%ebp),%eax
80102548:	8b 40 58             	mov    0x58(%eax),%eax
8010254b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010254e:	77 0d                	ja     8010255d <writei+0x9d>
80102550:	8b 55 10             	mov    0x10(%ebp),%edx
80102553:	8b 45 14             	mov    0x14(%ebp),%eax
80102556:	01 d0                	add    %edx,%eax
80102558:	39 45 10             	cmp    %eax,0x10(%ebp)
8010255b:	76 0a                	jbe    80102567 <writei+0xa7>
    return -1;
8010255d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102562:	e9 f3 00 00 00       	jmp    8010265a <writei+0x19a>
  if(off + n > MAXFILE*BSIZE)
80102567:	8b 55 10             	mov    0x10(%ebp),%edx
8010256a:	8b 45 14             	mov    0x14(%ebp),%eax
8010256d:	01 d0                	add    %edx,%eax
8010256f:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102574:	76 0a                	jbe    80102580 <writei+0xc0>
    return -1;
80102576:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010257b:	e9 da 00 00 00       	jmp    8010265a <writei+0x19a>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102580:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102587:	e9 97 00 00 00       	jmp    80102623 <writei+0x163>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010258c:	8b 45 10             	mov    0x10(%ebp),%eax
8010258f:	c1 e8 09             	shr    $0x9,%eax
80102592:	83 ec 08             	sub    $0x8,%esp
80102595:	50                   	push   %eax
80102596:	ff 75 08             	push   0x8(%ebp)
80102599:	e8 f6 fa ff ff       	call   80102094 <bmap>
8010259e:	83 c4 10             	add    $0x10,%esp
801025a1:	8b 55 08             	mov    0x8(%ebp),%edx
801025a4:	8b 12                	mov    (%edx),%edx
801025a6:	83 ec 08             	sub    $0x8,%esp
801025a9:	50                   	push   %eax
801025aa:	52                   	push   %edx
801025ab:	e8 5c dc ff ff       	call   8010020c <bread>
801025b0:	83 c4 10             	add    $0x10,%esp
801025b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801025b6:	8b 45 10             	mov    0x10(%ebp),%eax
801025b9:	25 ff 01 00 00       	and    $0x1ff,%eax
801025be:	ba 00 02 00 00       	mov    $0x200,%edx
801025c3:	29 c2                	sub    %eax,%edx
801025c5:	8b 45 14             	mov    0x14(%ebp),%eax
801025c8:	2b 45 f4             	sub    -0xc(%ebp),%eax
801025cb:	39 c2                	cmp    %eax,%edx
801025cd:	0f 46 c2             	cmovbe %edx,%eax
801025d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801025d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025d6:	8d 50 5c             	lea    0x5c(%eax),%edx
801025d9:	8b 45 10             	mov    0x10(%ebp),%eax
801025dc:	25 ff 01 00 00       	and    $0x1ff,%eax
801025e1:	01 d0                	add    %edx,%eax
801025e3:	83 ec 04             	sub    $0x4,%esp
801025e6:	ff 75 ec             	push   -0x14(%ebp)
801025e9:	ff 75 0c             	push   0xc(%ebp)
801025ec:	50                   	push   %eax
801025ed:	e8 d5 38 00 00       	call   80105ec7 <memmove>
801025f2:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801025f5:	83 ec 0c             	sub    $0xc,%esp
801025f8:	ff 75 f0             	push   -0x10(%ebp)
801025fb:	e8 04 19 00 00       	call   80103f04 <log_write>
80102600:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102603:	83 ec 0c             	sub    $0xc,%esp
80102606:	ff 75 f0             	push   -0x10(%ebp)
80102609:	e8 a0 dc ff ff       	call   801002ae <brelse>
8010260e:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102611:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102614:	01 45 f4             	add    %eax,-0xc(%ebp)
80102617:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010261a:	01 45 10             	add    %eax,0x10(%ebp)
8010261d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102620:	01 45 0c             	add    %eax,0xc(%ebp)
80102623:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102626:	3b 45 14             	cmp    0x14(%ebp),%eax
80102629:	0f 82 5d ff ff ff    	jb     8010258c <writei+0xcc>
  }

  if(n > 0 && off > ip->size){
8010262f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102633:	74 22                	je     80102657 <writei+0x197>
80102635:	8b 45 08             	mov    0x8(%ebp),%eax
80102638:	8b 40 58             	mov    0x58(%eax),%eax
8010263b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010263e:	76 17                	jbe    80102657 <writei+0x197>
    ip->size = off;
80102640:	8b 45 08             	mov    0x8(%ebp),%eax
80102643:	8b 55 10             	mov    0x10(%ebp),%edx
80102646:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
80102649:	83 ec 0c             	sub    $0xc,%esp
8010264c:	ff 75 08             	push   0x8(%ebp)
8010264f:	e8 89 f5 ff ff       	call   80101bdd <iupdate>
80102654:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102657:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010265a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010265d:	c9                   	leave  
8010265e:	c3                   	ret    

8010265f <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010265f:	55                   	push   %ebp
80102660:	89 e5                	mov    %esp,%ebp
80102662:	53                   	push   %ebx
80102663:	83 ec 04             	sub    $0x4,%esp
80102666:	e8 bd e6 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010266b:	05 55 9e 00 00       	add    $0x9e55,%eax
  return strncmp(s, t, DIRSIZ);
80102670:	83 ec 04             	sub    $0x4,%esp
80102673:	6a 0e                	push   $0xe
80102675:	ff 75 0c             	push   0xc(%ebp)
80102678:	ff 75 08             	push   0x8(%ebp)
8010267b:	89 c3                	mov    %eax,%ebx
8010267d:	e8 ef 38 00 00       	call   80105f71 <strncmp>
80102682:	83 c4 10             	add    $0x10,%esp
}
80102685:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102688:	c9                   	leave  
80102689:	c3                   	ret    

8010268a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
8010268a:	55                   	push   %ebp
8010268b:	89 e5                	mov    %esp,%ebp
8010268d:	53                   	push   %ebx
8010268e:	83 ec 24             	sub    $0x24,%esp
80102691:	e8 ef dc ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102696:	81 c3 2a 9e 00 00    	add    $0x9e2a,%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010269c:	8b 45 08             	mov    0x8(%ebp),%eax
8010269f:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801026a3:	66 83 f8 01          	cmp    $0x1,%ax
801026a7:	74 0f                	je     801026b8 <dirlookup+0x2e>
    panic("dirlookup not DIR");
801026a9:	83 ec 0c             	sub    $0xc,%esp
801026ac:	8d 83 05 d1 ff ff    	lea    -0x2efb(%ebx),%eax
801026b2:	50                   	push   %eax
801026b3:	e8 bd df ff ff       	call   80100675 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801026b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026bf:	eb 7d                	jmp    8010273e <dirlookup+0xb4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801026c1:	6a 10                	push   $0x10
801026c3:	ff 75 f4             	push   -0xc(%ebp)
801026c6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801026c9:	50                   	push   %eax
801026ca:	ff 75 08             	push   0x8(%ebp)
801026cd:	e8 82 fc ff ff       	call   80102354 <readi>
801026d2:	83 c4 10             	add    $0x10,%esp
801026d5:	83 f8 10             	cmp    $0x10,%eax
801026d8:	74 0f                	je     801026e9 <dirlookup+0x5f>
      panic("dirlookup read");
801026da:	83 ec 0c             	sub    $0xc,%esp
801026dd:	8d 83 17 d1 ff ff    	lea    -0x2ee9(%ebx),%eax
801026e3:	50                   	push   %eax
801026e4:	e8 8c df ff ff       	call   80100675 <panic>
    if(de.inum == 0)
801026e9:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801026ed:	66 85 c0             	test   %ax,%ax
801026f0:	74 47                	je     80102739 <dirlookup+0xaf>
      continue;
    if(namecmp(name, de.name) == 0){
801026f2:	83 ec 08             	sub    $0x8,%esp
801026f5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801026f8:	83 c0 02             	add    $0x2,%eax
801026fb:	50                   	push   %eax
801026fc:	ff 75 0c             	push   0xc(%ebp)
801026ff:	e8 5b ff ff ff       	call   8010265f <namecmp>
80102704:	83 c4 10             	add    $0x10,%esp
80102707:	85 c0                	test   %eax,%eax
80102709:	75 2f                	jne    8010273a <dirlookup+0xb0>
      // entry matches path element
      if(poff)
8010270b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010270f:	74 08                	je     80102719 <dirlookup+0x8f>
        *poff = off;
80102711:	8b 45 10             	mov    0x10(%ebp),%eax
80102714:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102717:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102719:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010271d:	0f b7 c0             	movzwl %ax,%eax
80102720:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102723:	8b 45 08             	mov    0x8(%ebp),%eax
80102726:	8b 00                	mov    (%eax),%eax
80102728:	83 ec 08             	sub    $0x8,%esp
8010272b:	ff 75 f0             	push   -0x10(%ebp)
8010272e:	50                   	push   %eax
8010272f:	e8 7a f5 ff ff       	call   80101cae <iget>
80102734:	83 c4 10             	add    $0x10,%esp
80102737:	eb 19                	jmp    80102752 <dirlookup+0xc8>
      continue;
80102739:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
8010273a:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010273e:	8b 45 08             	mov    0x8(%ebp),%eax
80102741:	8b 40 58             	mov    0x58(%eax),%eax
80102744:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102747:	0f 82 74 ff ff ff    	jb     801026c1 <dirlookup+0x37>
    }
  }

  return 0;
8010274d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102752:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102755:	c9                   	leave  
80102756:	c3                   	ret    

80102757 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102757:	55                   	push   %ebp
80102758:	89 e5                	mov    %esp,%ebp
8010275a:	53                   	push   %ebx
8010275b:	83 ec 24             	sub    $0x24,%esp
8010275e:	e8 22 dc ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102763:	81 c3 5d 9d 00 00    	add    $0x9d5d,%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102769:	83 ec 04             	sub    $0x4,%esp
8010276c:	6a 00                	push   $0x0
8010276e:	ff 75 0c             	push   0xc(%ebp)
80102771:	ff 75 08             	push   0x8(%ebp)
80102774:	e8 11 ff ff ff       	call   8010268a <dirlookup>
80102779:	83 c4 10             	add    $0x10,%esp
8010277c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010277f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102783:	74 18                	je     8010279d <dirlink+0x46>
    iput(ip);
80102785:	83 ec 0c             	sub    $0xc,%esp
80102788:	ff 75 f0             	push   -0x10(%ebp)
8010278b:	e8 ee f7 ff ff       	call   80101f7e <iput>
80102790:	83 c4 10             	add    $0x10,%esp
    return -1;
80102793:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102798:	e9 a0 00 00 00       	jmp    8010283d <dirlink+0xe6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010279d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801027a4:	eb 3b                	jmp    801027e1 <dirlink+0x8a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801027a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027a9:	6a 10                	push   $0x10
801027ab:	50                   	push   %eax
801027ac:	8d 45 e0             	lea    -0x20(%ebp),%eax
801027af:	50                   	push   %eax
801027b0:	ff 75 08             	push   0x8(%ebp)
801027b3:	e8 9c fb ff ff       	call   80102354 <readi>
801027b8:	83 c4 10             	add    $0x10,%esp
801027bb:	83 f8 10             	cmp    $0x10,%eax
801027be:	74 0f                	je     801027cf <dirlink+0x78>
      panic("dirlink read");
801027c0:	83 ec 0c             	sub    $0xc,%esp
801027c3:	8d 83 26 d1 ff ff    	lea    -0x2eda(%ebx),%eax
801027c9:	50                   	push   %eax
801027ca:	e8 a6 de ff ff       	call   80100675 <panic>
    if(de.inum == 0)
801027cf:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801027d3:	66 85 c0             	test   %ax,%ax
801027d6:	74 18                	je     801027f0 <dirlink+0x99>
  for(off = 0; off < dp->size; off += sizeof(de)){
801027d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027db:	83 c0 10             	add    $0x10,%eax
801027de:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027e1:	8b 45 08             	mov    0x8(%ebp),%eax
801027e4:	8b 50 58             	mov    0x58(%eax),%edx
801027e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027ea:	39 c2                	cmp    %eax,%edx
801027ec:	77 b8                	ja     801027a6 <dirlink+0x4f>
801027ee:	eb 01                	jmp    801027f1 <dirlink+0x9a>
      break;
801027f0:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801027f1:	83 ec 04             	sub    $0x4,%esp
801027f4:	6a 0e                	push   $0xe
801027f6:	ff 75 0c             	push   0xc(%ebp)
801027f9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801027fc:	83 c0 02             	add    $0x2,%eax
801027ff:	50                   	push   %eax
80102800:	e8 cc 37 00 00       	call   80105fd1 <strncpy>
80102805:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102808:	8b 45 10             	mov    0x10(%ebp),%eax
8010280b:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010280f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102812:	6a 10                	push   $0x10
80102814:	50                   	push   %eax
80102815:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102818:	50                   	push   %eax
80102819:	ff 75 08             	push   0x8(%ebp)
8010281c:	e8 9f fc ff ff       	call   801024c0 <writei>
80102821:	83 c4 10             	add    $0x10,%esp
80102824:	83 f8 10             	cmp    $0x10,%eax
80102827:	74 0f                	je     80102838 <dirlink+0xe1>
    panic("dirlink");
80102829:	83 ec 0c             	sub    $0xc,%esp
8010282c:	8d 83 33 d1 ff ff    	lea    -0x2ecd(%ebx),%eax
80102832:	50                   	push   %eax
80102833:	e8 3d de ff ff       	call   80100675 <panic>

  return 0;
80102838:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010283d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102840:	c9                   	leave  
80102841:	c3                   	ret    

80102842 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102842:	55                   	push   %ebp
80102843:	89 e5                	mov    %esp,%ebp
80102845:	53                   	push   %ebx
80102846:	83 ec 14             	sub    $0x14,%esp
80102849:	e8 da e4 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010284e:	05 72 9c 00 00       	add    $0x9c72,%eax
  char *s;
  int len;

  while(*path == '/')
80102853:	eb 04                	jmp    80102859 <skipelem+0x17>
    path++;
80102855:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
80102859:	8b 55 08             	mov    0x8(%ebp),%edx
8010285c:	0f b6 12             	movzbl (%edx),%edx
8010285f:	80 fa 2f             	cmp    $0x2f,%dl
80102862:	74 f1                	je     80102855 <skipelem+0x13>
  if(*path == 0)
80102864:	8b 55 08             	mov    0x8(%ebp),%edx
80102867:	0f b6 12             	movzbl (%edx),%edx
8010286a:	84 d2                	test   %dl,%dl
8010286c:	75 07                	jne    80102875 <skipelem+0x33>
    return 0;
8010286e:	b8 00 00 00 00       	mov    $0x0,%eax
80102873:	eb 7c                	jmp    801028f1 <skipelem+0xaf>
  s = path;
80102875:	8b 55 08             	mov    0x8(%ebp),%edx
80102878:	89 55 f4             	mov    %edx,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010287b:	eb 04                	jmp    80102881 <skipelem+0x3f>
    path++;
8010287d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
80102881:	8b 55 08             	mov    0x8(%ebp),%edx
80102884:	0f b6 12             	movzbl (%edx),%edx
80102887:	80 fa 2f             	cmp    $0x2f,%dl
8010288a:	74 0a                	je     80102896 <skipelem+0x54>
8010288c:	8b 55 08             	mov    0x8(%ebp),%edx
8010288f:	0f b6 12             	movzbl (%edx),%edx
80102892:	84 d2                	test   %dl,%dl
80102894:	75 e7                	jne    8010287d <skipelem+0x3b>
  len = path - s;
80102896:	8b 55 08             	mov    0x8(%ebp),%edx
80102899:	2b 55 f4             	sub    -0xc(%ebp),%edx
8010289c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  if(len >= DIRSIZ)
8010289f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801028a3:	7e 17                	jle    801028bc <skipelem+0x7a>
    memmove(name, s, DIRSIZ);
801028a5:	83 ec 04             	sub    $0x4,%esp
801028a8:	6a 0e                	push   $0xe
801028aa:	ff 75 f4             	push   -0xc(%ebp)
801028ad:	ff 75 0c             	push   0xc(%ebp)
801028b0:	89 c3                	mov    %eax,%ebx
801028b2:	e8 10 36 00 00       	call   80105ec7 <memmove>
801028b7:	83 c4 10             	add    $0x10,%esp
801028ba:	eb 28                	jmp    801028e4 <skipelem+0xa2>
  else {
    memmove(name, s, len);
801028bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801028bf:	83 ec 04             	sub    $0x4,%esp
801028c2:	52                   	push   %edx
801028c3:	ff 75 f4             	push   -0xc(%ebp)
801028c6:	ff 75 0c             	push   0xc(%ebp)
801028c9:	89 c3                	mov    %eax,%ebx
801028cb:	e8 f7 35 00 00       	call   80105ec7 <memmove>
801028d0:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
801028d3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801028d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801028d9:	01 d0                	add    %edx,%eax
801028db:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801028de:	eb 04                	jmp    801028e4 <skipelem+0xa2>
    path++;
801028e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
801028e4:	8b 45 08             	mov    0x8(%ebp),%eax
801028e7:	0f b6 00             	movzbl (%eax),%eax
801028ea:	3c 2f                	cmp    $0x2f,%al
801028ec:	74 f2                	je     801028e0 <skipelem+0x9e>
  return path;
801028ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
801028f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028f4:	c9                   	leave  
801028f5:	c3                   	ret    

801028f6 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801028f6:	55                   	push   %ebp
801028f7:	89 e5                	mov    %esp,%ebp
801028f9:	53                   	push   %ebx
801028fa:	83 ec 14             	sub    $0x14,%esp
801028fd:	e8 26 e4 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102902:	05 be 9b 00 00       	add    $0x9bbe,%eax
  struct inode *ip, *next;

  if(*path == '/')
80102907:	8b 55 08             	mov    0x8(%ebp),%edx
8010290a:	0f b6 12             	movzbl (%edx),%edx
8010290d:	80 fa 2f             	cmp    $0x2f,%dl
80102910:	75 17                	jne    80102929 <namex+0x33>
    ip = iget(ROOTDEV, ROOTINO);
80102912:	83 ec 08             	sub    $0x8,%esp
80102915:	6a 01                	push   $0x1
80102917:	6a 01                	push   $0x1
80102919:	e8 90 f3 ff ff       	call   80101cae <iget>
8010291e:	83 c4 10             	add    $0x10,%esp
80102921:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102924:	e9 bc 00 00 00       	jmp    801029e5 <namex+0xef>
  else
    ip = idup(myproc()->cwd);
80102929:	89 c3                	mov    %eax,%ebx
8010292b:	e8 76 22 00 00       	call   80104ba6 <myproc>
80102930:	8b 40 68             	mov    0x68(%eax),%eax
80102933:	83 ec 0c             	sub    $0xc,%esp
80102936:	50                   	push   %eax
80102937:	e8 6f f4 ff ff       	call   80101dab <idup>
8010293c:	83 c4 10             	add    $0x10,%esp
8010293f:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102942:	e9 9e 00 00 00       	jmp    801029e5 <namex+0xef>
    ilock(ip);
80102947:	83 ec 0c             	sub    $0xc,%esp
8010294a:	ff 75 f4             	push   -0xc(%ebp)
8010294d:	e8 a6 f4 ff ff       	call   80101df8 <ilock>
80102952:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
80102955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102958:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010295c:	66 83 f8 01          	cmp    $0x1,%ax
80102960:	74 18                	je     8010297a <namex+0x84>
      iunlockput(ip);
80102962:	83 ec 0c             	sub    $0xc,%esp
80102965:	ff 75 f4             	push   -0xc(%ebp)
80102968:	e8 f8 f6 ff ff       	call   80102065 <iunlockput>
8010296d:	83 c4 10             	add    $0x10,%esp
      return 0;
80102970:	b8 00 00 00 00       	mov    $0x0,%eax
80102975:	e9 a7 00 00 00       	jmp    80102a21 <namex+0x12b>
    }
    if(nameiparent && *path == '\0'){
8010297a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010297e:	74 20                	je     801029a0 <namex+0xaa>
80102980:	8b 45 08             	mov    0x8(%ebp),%eax
80102983:	0f b6 00             	movzbl (%eax),%eax
80102986:	84 c0                	test   %al,%al
80102988:	75 16                	jne    801029a0 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
8010298a:	83 ec 0c             	sub    $0xc,%esp
8010298d:	ff 75 f4             	push   -0xc(%ebp)
80102990:	e8 8a f5 ff ff       	call   80101f1f <iunlock>
80102995:	83 c4 10             	add    $0x10,%esp
      return ip;
80102998:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010299b:	e9 81 00 00 00       	jmp    80102a21 <namex+0x12b>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801029a0:	83 ec 04             	sub    $0x4,%esp
801029a3:	6a 00                	push   $0x0
801029a5:	ff 75 10             	push   0x10(%ebp)
801029a8:	ff 75 f4             	push   -0xc(%ebp)
801029ab:	e8 da fc ff ff       	call   8010268a <dirlookup>
801029b0:	83 c4 10             	add    $0x10,%esp
801029b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801029b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801029ba:	75 15                	jne    801029d1 <namex+0xdb>
      iunlockput(ip);
801029bc:	83 ec 0c             	sub    $0xc,%esp
801029bf:	ff 75 f4             	push   -0xc(%ebp)
801029c2:	e8 9e f6 ff ff       	call   80102065 <iunlockput>
801029c7:	83 c4 10             	add    $0x10,%esp
      return 0;
801029ca:	b8 00 00 00 00       	mov    $0x0,%eax
801029cf:	eb 50                	jmp    80102a21 <namex+0x12b>
    }
    iunlockput(ip);
801029d1:	83 ec 0c             	sub    $0xc,%esp
801029d4:	ff 75 f4             	push   -0xc(%ebp)
801029d7:	e8 89 f6 ff ff       	call   80102065 <iunlockput>
801029dc:	83 c4 10             	add    $0x10,%esp
    ip = next;
801029df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801029e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
801029e5:	83 ec 08             	sub    $0x8,%esp
801029e8:	ff 75 10             	push   0x10(%ebp)
801029eb:	ff 75 08             	push   0x8(%ebp)
801029ee:	e8 4f fe ff ff       	call   80102842 <skipelem>
801029f3:	83 c4 10             	add    $0x10,%esp
801029f6:	89 45 08             	mov    %eax,0x8(%ebp)
801029f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801029fd:	0f 85 44 ff ff ff    	jne    80102947 <namex+0x51>
  }
  if(nameiparent){
80102a03:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102a07:	74 15                	je     80102a1e <namex+0x128>
    iput(ip);
80102a09:	83 ec 0c             	sub    $0xc,%esp
80102a0c:	ff 75 f4             	push   -0xc(%ebp)
80102a0f:	e8 6a f5 ff ff       	call   80101f7e <iput>
80102a14:	83 c4 10             	add    $0x10,%esp
    return 0;
80102a17:	b8 00 00 00 00       	mov    $0x0,%eax
80102a1c:	eb 03                	jmp    80102a21 <namex+0x12b>
  }
  return ip;
80102a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102a21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a24:	c9                   	leave  
80102a25:	c3                   	ret    

80102a26 <namei>:

struct inode*
namei(char *path)
{
80102a26:	55                   	push   %ebp
80102a27:	89 e5                	mov    %esp,%ebp
80102a29:	83 ec 18             	sub    $0x18,%esp
80102a2c:	e8 f7 e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102a31:	05 8f 9a 00 00       	add    $0x9a8f,%eax
  char name[DIRSIZ];
  return namex(path, 0, name);
80102a36:	83 ec 04             	sub    $0x4,%esp
80102a39:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102a3c:	50                   	push   %eax
80102a3d:	6a 00                	push   $0x0
80102a3f:	ff 75 08             	push   0x8(%ebp)
80102a42:	e8 af fe ff ff       	call   801028f6 <namex>
80102a47:	83 c4 10             	add    $0x10,%esp
}
80102a4a:	c9                   	leave  
80102a4b:	c3                   	ret    

80102a4c <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102a4c:	55                   	push   %ebp
80102a4d:	89 e5                	mov    %esp,%ebp
80102a4f:	83 ec 08             	sub    $0x8,%esp
80102a52:	e8 d1 e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102a57:	05 69 9a 00 00       	add    $0x9a69,%eax
  return namex(path, 1, name);
80102a5c:	83 ec 04             	sub    $0x4,%esp
80102a5f:	ff 75 0c             	push   0xc(%ebp)
80102a62:	6a 01                	push   $0x1
80102a64:	ff 75 08             	push   0x8(%ebp)
80102a67:	e8 8a fe ff ff       	call   801028f6 <namex>
80102a6c:	83 c4 10             	add    $0x10,%esp
}
80102a6f:	c9                   	leave  
80102a70:	c3                   	ret    

80102a71 <inb>:
{
80102a71:	55                   	push   %ebp
80102a72:	89 e5                	mov    %esp,%ebp
80102a74:	83 ec 14             	sub    $0x14,%esp
80102a77:	e8 ac e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102a7c:	05 44 9a 00 00       	add    $0x9a44,%eax
80102a81:	8b 45 08             	mov    0x8(%ebp),%eax
80102a84:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a88:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102a8c:	89 c2                	mov    %eax,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102a92:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102a96:	c9                   	leave  
80102a97:	c3                   	ret    

80102a98 <insl>:
{
80102a98:	55                   	push   %ebp
80102a99:	89 e5                	mov    %esp,%ebp
80102a9b:	57                   	push   %edi
80102a9c:	53                   	push   %ebx
80102a9d:	e8 86 e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102aa2:	05 1e 9a 00 00       	add    $0x9a1e,%eax
  asm volatile("cld; rep insl" :
80102aa7:	8b 55 08             	mov    0x8(%ebp),%edx
80102aaa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102aad:	8b 45 10             	mov    0x10(%ebp),%eax
80102ab0:	89 cb                	mov    %ecx,%ebx
80102ab2:	89 df                	mov    %ebx,%edi
80102ab4:	89 c1                	mov    %eax,%ecx
80102ab6:	fc                   	cld    
80102ab7:	f3 6d                	rep insl (%dx),%es:(%edi)
80102ab9:	89 c8                	mov    %ecx,%eax
80102abb:	89 fb                	mov    %edi,%ebx
80102abd:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102ac0:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102ac3:	90                   	nop
80102ac4:	5b                   	pop    %ebx
80102ac5:	5f                   	pop    %edi
80102ac6:	5d                   	pop    %ebp
80102ac7:	c3                   	ret    

80102ac8 <outb>:
{
80102ac8:	55                   	push   %ebp
80102ac9:	89 e5                	mov    %esp,%ebp
80102acb:	83 ec 08             	sub    $0x8,%esp
80102ace:	e8 55 e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102ad3:	05 ed 99 00 00       	add    $0x99ed,%eax
80102ad8:	8b 45 08             	mov    0x8(%ebp),%eax
80102adb:	8b 55 0c             	mov    0xc(%ebp),%edx
80102ade:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102ae2:	89 d0                	mov    %edx,%eax
80102ae4:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae7:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102aeb:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102aef:	ee                   	out    %al,(%dx)
}
80102af0:	90                   	nop
80102af1:	c9                   	leave  
80102af2:	c3                   	ret    

80102af3 <outsl>:
{
80102af3:	55                   	push   %ebp
80102af4:	89 e5                	mov    %esp,%ebp
80102af6:	56                   	push   %esi
80102af7:	53                   	push   %ebx
80102af8:	e8 2b e2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102afd:	05 c3 99 00 00       	add    $0x99c3,%eax
  asm volatile("cld; rep outsl" :
80102b02:	8b 55 08             	mov    0x8(%ebp),%edx
80102b05:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b08:	8b 45 10             	mov    0x10(%ebp),%eax
80102b0b:	89 cb                	mov    %ecx,%ebx
80102b0d:	89 de                	mov    %ebx,%esi
80102b0f:	89 c1                	mov    %eax,%ecx
80102b11:	fc                   	cld    
80102b12:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102b14:	89 c8                	mov    %ecx,%eax
80102b16:	89 f3                	mov    %esi,%ebx
80102b18:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102b1b:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102b1e:	90                   	nop
80102b1f:	5b                   	pop    %ebx
80102b20:	5e                   	pop    %esi
80102b21:	5d                   	pop    %ebp
80102b22:	c3                   	ret    

80102b23 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102b23:	55                   	push   %ebp
80102b24:	89 e5                	mov    %esp,%ebp
80102b26:	83 ec 10             	sub    $0x10,%esp
80102b29:	e8 fa e1 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102b2e:	05 92 99 00 00       	add    $0x9992,%eax
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102b33:	90                   	nop
80102b34:	68 f7 01 00 00       	push   $0x1f7
80102b39:	e8 33 ff ff ff       	call   80102a71 <inb>
80102b3e:	83 c4 04             	add    $0x4,%esp
80102b41:	0f b6 c0             	movzbl %al,%eax
80102b44:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102b47:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102b4a:	25 c0 00 00 00       	and    $0xc0,%eax
80102b4f:	83 f8 40             	cmp    $0x40,%eax
80102b52:	75 e0                	jne    80102b34 <idewait+0x11>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102b54:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102b58:	74 11                	je     80102b6b <idewait+0x48>
80102b5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102b5d:	83 e0 21             	and    $0x21,%eax
80102b60:	85 c0                	test   %eax,%eax
80102b62:	74 07                	je     80102b6b <idewait+0x48>
    return -1;
80102b64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b69:	eb 05                	jmp    80102b70 <idewait+0x4d>
  return 0;
80102b6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102b70:	c9                   	leave  
80102b71:	c3                   	ret    

80102b72 <ideinit>:

void
ideinit(void)
{
80102b72:	55                   	push   %ebp
80102b73:	89 e5                	mov    %esp,%ebp
80102b75:	53                   	push   %ebx
80102b76:	83 ec 14             	sub    $0x14,%esp
80102b79:	e8 07 d8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102b7e:	81 c3 42 99 00 00    	add    $0x9942,%ebx
  int i;

  initlock(&idelock, "ide");
80102b84:	83 ec 08             	sub    $0x8,%esp
80102b87:	8d 83 3b d1 ff ff    	lea    -0x2ec5(%ebx),%eax
80102b8d:	50                   	push   %eax
80102b8e:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102b94:	50                   	push   %eax
80102b95:	e8 3c 2f 00 00       	call   80105ad6 <initlock>
80102b9a:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102b9d:	c7 c0 60 3d 11 80    	mov    $0x80113d60,%eax
80102ba3:	8b 00                	mov    (%eax),%eax
80102ba5:	83 e8 01             	sub    $0x1,%eax
80102ba8:	83 ec 08             	sub    $0x8,%esp
80102bab:	50                   	push   %eax
80102bac:	6a 0e                	push   $0xe
80102bae:	e8 24 05 00 00       	call   801030d7 <ioapicenable>
80102bb3:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102bb6:	83 ec 0c             	sub    $0xc,%esp
80102bb9:	6a 00                	push   $0x0
80102bbb:	e8 63 ff ff ff       	call   80102b23 <idewait>
80102bc0:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102bc3:	83 ec 08             	sub    $0x8,%esp
80102bc6:	68 f0 00 00 00       	push   $0xf0
80102bcb:	68 f6 01 00 00       	push   $0x1f6
80102bd0:	e8 f3 fe ff ff       	call   80102ac8 <outb>
80102bd5:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102bd8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102bdf:	eb 24                	jmp    80102c05 <ideinit+0x93>
    if(inb(0x1f7) != 0){
80102be1:	83 ec 0c             	sub    $0xc,%esp
80102be4:	68 f7 01 00 00       	push   $0x1f7
80102be9:	e8 83 fe ff ff       	call   80102a71 <inb>
80102bee:	83 c4 10             	add    $0x10,%esp
80102bf1:	84 c0                	test   %al,%al
80102bf3:	74 0c                	je     80102c01 <ideinit+0x8f>
      havedisk1 = 1;
80102bf5:	c7 83 d8 71 00 00 01 	movl   $0x1,0x71d8(%ebx)
80102bfc:	00 00 00 
      break;
80102bff:	eb 0d                	jmp    80102c0e <ideinit+0x9c>
  for(i=0; i<1000; i++){
80102c01:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102c05:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102c0c:	7e d3                	jle    80102be1 <ideinit+0x6f>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102c0e:	83 ec 08             	sub    $0x8,%esp
80102c11:	68 e0 00 00 00       	push   $0xe0
80102c16:	68 f6 01 00 00       	push   $0x1f6
80102c1b:	e8 a8 fe ff ff       	call   80102ac8 <outb>
80102c20:	83 c4 10             	add    $0x10,%esp
}
80102c23:	90                   	nop
80102c24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c27:	c9                   	leave  
80102c28:	c3                   	ret    

80102c29 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102c29:	55                   	push   %ebp
80102c2a:	89 e5                	mov    %esp,%ebp
80102c2c:	53                   	push   %ebx
80102c2d:	83 ec 14             	sub    $0x14,%esp
80102c30:	e8 f3 e0 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102c35:	05 8b 98 00 00       	add    $0x988b,%eax
  if(b == 0)
80102c3a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102c3e:	75 11                	jne    80102c51 <idestart+0x28>
    panic("idestart");
80102c40:	83 ec 0c             	sub    $0xc,%esp
80102c43:	8d 90 3f d1 ff ff    	lea    -0x2ec1(%eax),%edx
80102c49:	52                   	push   %edx
80102c4a:	89 c3                	mov    %eax,%ebx
80102c4c:	e8 24 da ff ff       	call   80100675 <panic>
  if(b->blockno >= FSSIZE)
80102c51:	8b 55 08             	mov    0x8(%ebp),%edx
80102c54:	8b 52 08             	mov    0x8(%edx),%edx
80102c57:	81 fa e7 03 00 00    	cmp    $0x3e7,%edx
80102c5d:	76 11                	jbe    80102c70 <idestart+0x47>
    panic("incorrect blockno");
80102c5f:	83 ec 0c             	sub    $0xc,%esp
80102c62:	8d 90 48 d1 ff ff    	lea    -0x2eb8(%eax),%edx
80102c68:	52                   	push   %edx
80102c69:	89 c3                	mov    %eax,%ebx
80102c6b:	e8 05 da ff ff       	call   80100675 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102c70:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102c77:	8b 55 08             	mov    0x8(%ebp),%edx
80102c7a:	8b 4a 08             	mov    0x8(%edx),%ecx
80102c7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102c80:	0f af d1             	imul   %ecx,%edx
80102c83:	89 55 f0             	mov    %edx,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102c86:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102c8a:	75 07                	jne    80102c93 <idestart+0x6a>
80102c8c:	ba 20 00 00 00       	mov    $0x20,%edx
80102c91:	eb 05                	jmp    80102c98 <idestart+0x6f>
80102c93:	ba c4 00 00 00       	mov    $0xc4,%edx
80102c98:	89 55 ec             	mov    %edx,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
80102c9b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102c9f:	75 07                	jne    80102ca8 <idestart+0x7f>
80102ca1:	ba 30 00 00 00       	mov    $0x30,%edx
80102ca6:	eb 05                	jmp    80102cad <idestart+0x84>
80102ca8:	ba c5 00 00 00       	mov    $0xc5,%edx
80102cad:	89 55 e8             	mov    %edx,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102cb0:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102cb4:	7e 11                	jle    80102cc7 <idestart+0x9e>
80102cb6:	83 ec 0c             	sub    $0xc,%esp
80102cb9:	8d 90 3f d1 ff ff    	lea    -0x2ec1(%eax),%edx
80102cbf:	52                   	push   %edx
80102cc0:	89 c3                	mov    %eax,%ebx
80102cc2:	e8 ae d9 ff ff       	call   80100675 <panic>

  idewait(0);
80102cc7:	83 ec 0c             	sub    $0xc,%esp
80102cca:	6a 00                	push   $0x0
80102ccc:	e8 52 fe ff ff       	call   80102b23 <idewait>
80102cd1:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102cd4:	83 ec 08             	sub    $0x8,%esp
80102cd7:	6a 00                	push   $0x0
80102cd9:	68 f6 03 00 00       	push   $0x3f6
80102cde:	e8 e5 fd ff ff       	call   80102ac8 <outb>
80102ce3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ce9:	0f b6 c0             	movzbl %al,%eax
80102cec:	83 ec 08             	sub    $0x8,%esp
80102cef:	50                   	push   %eax
80102cf0:	68 f2 01 00 00       	push   $0x1f2
80102cf5:	e8 ce fd ff ff       	call   80102ac8 <outb>
80102cfa:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
80102cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102d00:	0f b6 c0             	movzbl %al,%eax
80102d03:	83 ec 08             	sub    $0x8,%esp
80102d06:	50                   	push   %eax
80102d07:	68 f3 01 00 00       	push   $0x1f3
80102d0c:	e8 b7 fd ff ff       	call   80102ac8 <outb>
80102d11:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
80102d14:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102d17:	c1 f8 08             	sar    $0x8,%eax
80102d1a:	0f b6 c0             	movzbl %al,%eax
80102d1d:	83 ec 08             	sub    $0x8,%esp
80102d20:	50                   	push   %eax
80102d21:	68 f4 01 00 00       	push   $0x1f4
80102d26:	e8 9d fd ff ff       	call   80102ac8 <outb>
80102d2b:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
80102d2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102d31:	c1 f8 10             	sar    $0x10,%eax
80102d34:	0f b6 c0             	movzbl %al,%eax
80102d37:	83 ec 08             	sub    $0x8,%esp
80102d3a:	50                   	push   %eax
80102d3b:	68 f5 01 00 00       	push   $0x1f5
80102d40:	e8 83 fd ff ff       	call   80102ac8 <outb>
80102d45:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102d48:	8b 45 08             	mov    0x8(%ebp),%eax
80102d4b:	8b 40 04             	mov    0x4(%eax),%eax
80102d4e:	c1 e0 04             	shl    $0x4,%eax
80102d51:	83 e0 10             	and    $0x10,%eax
80102d54:	89 c2                	mov    %eax,%edx
80102d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102d59:	c1 f8 18             	sar    $0x18,%eax
80102d5c:	83 e0 0f             	and    $0xf,%eax
80102d5f:	09 d0                	or     %edx,%eax
80102d61:	83 c8 e0             	or     $0xffffffe0,%eax
80102d64:	0f b6 c0             	movzbl %al,%eax
80102d67:	83 ec 08             	sub    $0x8,%esp
80102d6a:	50                   	push   %eax
80102d6b:	68 f6 01 00 00       	push   $0x1f6
80102d70:	e8 53 fd ff ff       	call   80102ac8 <outb>
80102d75:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102d78:	8b 45 08             	mov    0x8(%ebp),%eax
80102d7b:	8b 00                	mov    (%eax),%eax
80102d7d:	83 e0 04             	and    $0x4,%eax
80102d80:	85 c0                	test   %eax,%eax
80102d82:	74 35                	je     80102db9 <idestart+0x190>
    outb(0x1f7, write_cmd);
80102d84:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102d87:	0f b6 c0             	movzbl %al,%eax
80102d8a:	83 ec 08             	sub    $0x8,%esp
80102d8d:	50                   	push   %eax
80102d8e:	68 f7 01 00 00       	push   $0x1f7
80102d93:	e8 30 fd ff ff       	call   80102ac8 <outb>
80102d98:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102d9b:	8b 45 08             	mov    0x8(%ebp),%eax
80102d9e:	83 c0 5c             	add    $0x5c,%eax
80102da1:	83 ec 04             	sub    $0x4,%esp
80102da4:	68 80 00 00 00       	push   $0x80
80102da9:	50                   	push   %eax
80102daa:	68 f0 01 00 00       	push   $0x1f0
80102daf:	e8 3f fd ff ff       	call   80102af3 <outsl>
80102db4:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102db7:	eb 17                	jmp    80102dd0 <idestart+0x1a7>
    outb(0x1f7, read_cmd);
80102db9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102dbc:	0f b6 c0             	movzbl %al,%eax
80102dbf:	83 ec 08             	sub    $0x8,%esp
80102dc2:	50                   	push   %eax
80102dc3:	68 f7 01 00 00       	push   $0x1f7
80102dc8:	e8 fb fc ff ff       	call   80102ac8 <outb>
80102dcd:	83 c4 10             	add    $0x10,%esp
}
80102dd0:	90                   	nop
80102dd1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dd4:	c9                   	leave  
80102dd5:	c3                   	ret    

80102dd6 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102dd6:	55                   	push   %ebp
80102dd7:	89 e5                	mov    %esp,%ebp
80102dd9:	53                   	push   %ebx
80102dda:	83 ec 14             	sub    $0x14,%esp
80102ddd:	e8 a3 d5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102de2:	81 c3 de 96 00 00    	add    $0x96de,%ebx
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102de8:	83 ec 0c             	sub    $0xc,%esp
80102deb:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102df1:	50                   	push   %eax
80102df2:	e8 0b 2d 00 00       	call   80105b02 <acquire>
80102df7:	83 c4 10             	add    $0x10,%esp

  if((b = idequeue) == 0){
80102dfa:	8b 83 d4 71 00 00    	mov    0x71d4(%ebx),%eax
80102e00:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102e03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102e07:	75 17                	jne    80102e20 <ideintr+0x4a>
    release(&idelock);
80102e09:	83 ec 0c             	sub    $0xc,%esp
80102e0c:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102e12:	50                   	push   %eax
80102e13:	e8 65 2d 00 00       	call   80105b7d <release>
80102e18:	83 c4 10             	add    $0x10,%esp
    return;
80102e1b:	e9 9f 00 00 00       	jmp    80102ebf <ideintr+0xe9>
  }
  idequeue = b->qnext;
80102e20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e23:	8b 40 58             	mov    0x58(%eax),%eax
80102e26:	89 83 d4 71 00 00    	mov    %eax,0x71d4(%ebx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e2f:	8b 00                	mov    (%eax),%eax
80102e31:	83 e0 04             	and    $0x4,%eax
80102e34:	85 c0                	test   %eax,%eax
80102e36:	75 2d                	jne    80102e65 <ideintr+0x8f>
80102e38:	83 ec 0c             	sub    $0xc,%esp
80102e3b:	6a 01                	push   $0x1
80102e3d:	e8 e1 fc ff ff       	call   80102b23 <idewait>
80102e42:	83 c4 10             	add    $0x10,%esp
80102e45:	85 c0                	test   %eax,%eax
80102e47:	78 1c                	js     80102e65 <ideintr+0x8f>
    insl(0x1f0, b->data, BSIZE/4);
80102e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e4c:	83 c0 5c             	add    $0x5c,%eax
80102e4f:	83 ec 04             	sub    $0x4,%esp
80102e52:	68 80 00 00 00       	push   $0x80
80102e57:	50                   	push   %eax
80102e58:	68 f0 01 00 00       	push   $0x1f0
80102e5d:	e8 36 fc ff ff       	call   80102a98 <insl>
80102e62:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102e65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e68:	8b 00                	mov    (%eax),%eax
80102e6a:	83 c8 02             	or     $0x2,%eax
80102e6d:	89 c2                	mov    %eax,%edx
80102e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e72:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e77:	8b 00                	mov    (%eax),%eax
80102e79:	83 e0 fb             	and    $0xfffffffb,%eax
80102e7c:	89 c2                	mov    %eax,%edx
80102e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e81:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102e83:	83 ec 0c             	sub    $0xc,%esp
80102e86:	ff 75 f4             	push   -0xc(%ebp)
80102e89:	e8 be 27 00 00       	call   8010564c <wakeup>
80102e8e:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102e91:	8b 83 d4 71 00 00    	mov    0x71d4(%ebx),%eax
80102e97:	85 c0                	test   %eax,%eax
80102e99:	74 12                	je     80102ead <ideintr+0xd7>
    idestart(idequeue);
80102e9b:	8b 83 d4 71 00 00    	mov    0x71d4(%ebx),%eax
80102ea1:	83 ec 0c             	sub    $0xc,%esp
80102ea4:	50                   	push   %eax
80102ea5:	e8 7f fd ff ff       	call   80102c29 <idestart>
80102eaa:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102ead:	83 ec 0c             	sub    $0xc,%esp
80102eb0:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102eb6:	50                   	push   %eax
80102eb7:	e8 c1 2c 00 00       	call   80105b7d <release>
80102ebc:	83 c4 10             	add    $0x10,%esp
}
80102ebf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ec2:	c9                   	leave  
80102ec3:	c3                   	ret    

80102ec4 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102ec4:	55                   	push   %ebp
80102ec5:	89 e5                	mov    %esp,%ebp
80102ec7:	53                   	push   %ebx
80102ec8:	83 ec 14             	sub    $0x14,%esp
80102ecb:	e8 b5 d4 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80102ed0:	81 c3 f0 95 00 00    	add    $0x95f0,%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102ed6:	8b 45 08             	mov    0x8(%ebp),%eax
80102ed9:	83 c0 0c             	add    $0xc,%eax
80102edc:	83 ec 0c             	sub    $0xc,%esp
80102edf:	50                   	push   %eax
80102ee0:	e8 26 2b 00 00       	call   80105a0b <holdingsleep>
80102ee5:	83 c4 10             	add    $0x10,%esp
80102ee8:	85 c0                	test   %eax,%eax
80102eea:	75 0f                	jne    80102efb <iderw+0x37>
    panic("iderw: buf not locked");
80102eec:	83 ec 0c             	sub    $0xc,%esp
80102eef:	8d 83 5a d1 ff ff    	lea    -0x2ea6(%ebx),%eax
80102ef5:	50                   	push   %eax
80102ef6:	e8 7a d7 ff ff       	call   80100675 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102efb:	8b 45 08             	mov    0x8(%ebp),%eax
80102efe:	8b 00                	mov    (%eax),%eax
80102f00:	83 e0 06             	and    $0x6,%eax
80102f03:	83 f8 02             	cmp    $0x2,%eax
80102f06:	75 0f                	jne    80102f17 <iderw+0x53>
    panic("iderw: nothing to do");
80102f08:	83 ec 0c             	sub    $0xc,%esp
80102f0b:	8d 83 70 d1 ff ff    	lea    -0x2e90(%ebx),%eax
80102f11:	50                   	push   %eax
80102f12:	e8 5e d7 ff ff       	call   80100675 <panic>
  if(b->dev != 0 && !havedisk1)
80102f17:	8b 45 08             	mov    0x8(%ebp),%eax
80102f1a:	8b 40 04             	mov    0x4(%eax),%eax
80102f1d:	85 c0                	test   %eax,%eax
80102f1f:	74 19                	je     80102f3a <iderw+0x76>
80102f21:	8b 83 d8 71 00 00    	mov    0x71d8(%ebx),%eax
80102f27:	85 c0                	test   %eax,%eax
80102f29:	75 0f                	jne    80102f3a <iderw+0x76>
    panic("iderw: ide disk 1 not present");
80102f2b:	83 ec 0c             	sub    $0xc,%esp
80102f2e:	8d 83 85 d1 ff ff    	lea    -0x2e7b(%ebx),%eax
80102f34:	50                   	push   %eax
80102f35:	e8 3b d7 ff ff       	call   80100675 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102f3a:	83 ec 0c             	sub    $0xc,%esp
80102f3d:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102f43:	50                   	push   %eax
80102f44:	e8 b9 2b 00 00       	call   80105b02 <acquire>
80102f49:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102f4c:	8b 45 08             	mov    0x8(%ebp),%eax
80102f4f:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f56:	8d 83 d4 71 00 00    	lea    0x71d4(%ebx),%eax
80102f5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102f5f:	eb 0b                	jmp    80102f6c <iderw+0xa8>
80102f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f64:	8b 00                	mov    (%eax),%eax
80102f66:	83 c0 58             	add    $0x58,%eax
80102f69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f6f:	8b 00                	mov    (%eax),%eax
80102f71:	85 c0                	test   %eax,%eax
80102f73:	75 ec                	jne    80102f61 <iderw+0x9d>
    ;
  *pp = b;
80102f75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f78:	8b 55 08             	mov    0x8(%ebp),%edx
80102f7b:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80102f7d:	8b 83 d4 71 00 00    	mov    0x71d4(%ebx),%eax
80102f83:	39 45 08             	cmp    %eax,0x8(%ebp)
80102f86:	75 25                	jne    80102fad <iderw+0xe9>
    idestart(b);
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	ff 75 08             	push   0x8(%ebp)
80102f8e:	e8 96 fc ff ff       	call   80102c29 <idestart>
80102f93:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f96:	eb 15                	jmp    80102fad <iderw+0xe9>
    sleep(b, &idelock);
80102f98:	83 ec 08             	sub    $0x8,%esp
80102f9b:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102fa1:	50                   	push   %eax
80102fa2:	ff 75 08             	push   0x8(%ebp)
80102fa5:	e8 92 25 00 00       	call   8010553c <sleep>
80102faa:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102fad:	8b 45 08             	mov    0x8(%ebp),%eax
80102fb0:	8b 00                	mov    (%eax),%eax
80102fb2:	83 e0 06             	and    $0x6,%eax
80102fb5:	83 f8 02             	cmp    $0x2,%eax
80102fb8:	75 de                	jne    80102f98 <iderw+0xd4>
  }


  release(&idelock);
80102fba:	83 ec 0c             	sub    $0xc,%esp
80102fbd:	8d 83 a0 71 00 00    	lea    0x71a0(%ebx),%eax
80102fc3:	50                   	push   %eax
80102fc4:	e8 b4 2b 00 00       	call   80105b7d <release>
80102fc9:	83 c4 10             	add    $0x10,%esp
}
80102fcc:	90                   	nop
80102fcd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fd0:	c9                   	leave  
80102fd1:	c3                   	ret    

80102fd2 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102fd2:	55                   	push   %ebp
80102fd3:	89 e5                	mov    %esp,%ebp
80102fd5:	e8 4e dd ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102fda:	05 e6 94 00 00       	add    $0x94e6,%eax
  ioapic->reg = reg;
80102fdf:	8b 90 dc 71 00 00    	mov    0x71dc(%eax),%edx
80102fe5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102fe8:	89 0a                	mov    %ecx,(%edx)
  return ioapic->data;
80102fea:	8b 80 dc 71 00 00    	mov    0x71dc(%eax),%eax
80102ff0:	8b 40 10             	mov    0x10(%eax),%eax
}
80102ff3:	5d                   	pop    %ebp
80102ff4:	c3                   	ret    

80102ff5 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102ff5:	55                   	push   %ebp
80102ff6:	89 e5                	mov    %esp,%ebp
80102ff8:	e8 2b dd ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80102ffd:	05 c3 94 00 00       	add    $0x94c3,%eax
  ioapic->reg = reg;
80103002:	8b 90 dc 71 00 00    	mov    0x71dc(%eax),%edx
80103008:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010300b:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010300d:	8b 80 dc 71 00 00    	mov    0x71dc(%eax),%eax
80103013:	8b 55 0c             	mov    0xc(%ebp),%edx
80103016:	89 50 10             	mov    %edx,0x10(%eax)
}
80103019:	90                   	nop
8010301a:	5d                   	pop    %ebp
8010301b:	c3                   	ret    

8010301c <ioapicinit>:

void
ioapicinit(void)
{
8010301c:	55                   	push   %ebp
8010301d:	89 e5                	mov    %esp,%ebp
8010301f:	53                   	push   %ebx
80103020:	83 ec 14             	sub    $0x14,%esp
80103023:	e8 5d d3 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103028:	81 c3 98 94 00 00    	add    $0x9498,%ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010302e:	c7 83 dc 71 00 00 00 	movl   $0xfec00000,0x71dc(%ebx)
80103035:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103038:	6a 01                	push   $0x1
8010303a:	e8 93 ff ff ff       	call   80102fd2 <ioapicread>
8010303f:	83 c4 04             	add    $0x4,%esp
80103042:	c1 e8 10             	shr    $0x10,%eax
80103045:	25 ff 00 00 00       	and    $0xff,%eax
8010304a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
8010304d:	6a 00                	push   $0x0
8010304f:	e8 7e ff ff ff       	call   80102fd2 <ioapicread>
80103054:	83 c4 04             	add    $0x4,%esp
80103057:	c1 e8 18             	shr    $0x18,%eax
8010305a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
8010305d:	c7 c0 64 3d 11 80    	mov    $0x80113d64,%eax
80103063:	0f b6 00             	movzbl (%eax),%eax
80103066:	0f b6 c0             	movzbl %al,%eax
80103069:	39 45 ec             	cmp    %eax,-0x14(%ebp)
8010306c:	74 12                	je     80103080 <ioapicinit+0x64>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010306e:	83 ec 0c             	sub    $0xc,%esp
80103071:	8d 83 a4 d1 ff ff    	lea    -0x2e5c(%ebx),%eax
80103077:	50                   	push   %eax
80103078:	e8 2b d4 ff ff       	call   801004a8 <cprintf>
8010307d:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103080:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103087:	eb 3f                	jmp    801030c8 <ioapicinit+0xac>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103089:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010308c:	83 c0 20             	add    $0x20,%eax
8010308f:	0d 00 00 01 00       	or     $0x10000,%eax
80103094:	89 c2                	mov    %eax,%edx
80103096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103099:	83 c0 08             	add    $0x8,%eax
8010309c:	01 c0                	add    %eax,%eax
8010309e:	83 ec 08             	sub    $0x8,%esp
801030a1:	52                   	push   %edx
801030a2:	50                   	push   %eax
801030a3:	e8 4d ff ff ff       	call   80102ff5 <ioapicwrite>
801030a8:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
801030ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030ae:	83 c0 08             	add    $0x8,%eax
801030b1:	01 c0                	add    %eax,%eax
801030b3:	83 c0 01             	add    $0x1,%eax
801030b6:	83 ec 08             	sub    $0x8,%esp
801030b9:	6a 00                	push   $0x0
801030bb:	50                   	push   %eax
801030bc:	e8 34 ff ff ff       	call   80102ff5 <ioapicwrite>
801030c1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
801030c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801030c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030cb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801030ce:	7e b9                	jle    80103089 <ioapicinit+0x6d>
  }
}
801030d0:	90                   	nop
801030d1:	90                   	nop
801030d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030d5:	c9                   	leave  
801030d6:	c3                   	ret    

801030d7 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801030d7:	55                   	push   %ebp
801030d8:	89 e5                	mov    %esp,%ebp
801030da:	e8 49 dc ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801030df:	05 e1 93 00 00       	add    $0x93e1,%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801030e4:	8b 45 08             	mov    0x8(%ebp),%eax
801030e7:	83 c0 20             	add    $0x20,%eax
801030ea:	89 c2                	mov    %eax,%edx
801030ec:	8b 45 08             	mov    0x8(%ebp),%eax
801030ef:	83 c0 08             	add    $0x8,%eax
801030f2:	01 c0                	add    %eax,%eax
801030f4:	52                   	push   %edx
801030f5:	50                   	push   %eax
801030f6:	e8 fa fe ff ff       	call   80102ff5 <ioapicwrite>
801030fb:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801030fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80103101:	c1 e0 18             	shl    $0x18,%eax
80103104:	89 c2                	mov    %eax,%edx
80103106:	8b 45 08             	mov    0x8(%ebp),%eax
80103109:	83 c0 08             	add    $0x8,%eax
8010310c:	01 c0                	add    %eax,%eax
8010310e:	83 c0 01             	add    $0x1,%eax
80103111:	52                   	push   %edx
80103112:	50                   	push   %eax
80103113:	e8 dd fe ff ff       	call   80102ff5 <ioapicwrite>
80103118:	83 c4 08             	add    $0x8,%esp
}
8010311b:	90                   	nop
8010311c:	c9                   	leave  
8010311d:	c3                   	ret    

8010311e <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
8010311e:	55                   	push   %ebp
8010311f:	89 e5                	mov    %esp,%ebp
80103121:	53                   	push   %ebx
80103122:	83 ec 04             	sub    $0x4,%esp
80103125:	e8 5b d2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010312a:	81 c3 96 93 00 00    	add    $0x9396,%ebx
  initlock(&kmem.lock, "kmem");
80103130:	83 ec 08             	sub    $0x8,%esp
80103133:	8d 83 d6 d1 ff ff    	lea    -0x2e2a(%ebx),%eax
80103139:	50                   	push   %eax
8010313a:	8d 83 e0 71 00 00    	lea    0x71e0(%ebx),%eax
80103140:	50                   	push   %eax
80103141:	e8 90 29 00 00       	call   80105ad6 <initlock>
80103146:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103149:	c7 83 14 72 00 00 00 	movl   $0x0,0x7214(%ebx)
80103150:	00 00 00 
  freerange(vstart, vend);
80103153:	83 ec 08             	sub    $0x8,%esp
80103156:	ff 75 0c             	push   0xc(%ebp)
80103159:	ff 75 08             	push   0x8(%ebp)
8010315c:	e8 3c 00 00 00       	call   8010319d <freerange>
80103161:	83 c4 10             	add    $0x10,%esp
}
80103164:	90                   	nop
80103165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103168:	c9                   	leave  
80103169:	c3                   	ret    

8010316a <kinit2>:

void
kinit2(void *vstart, void *vend)
{
8010316a:	55                   	push   %ebp
8010316b:	89 e5                	mov    %esp,%ebp
8010316d:	53                   	push   %ebx
8010316e:	83 ec 04             	sub    $0x4,%esp
80103171:	e8 0f d2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103176:	81 c3 4a 93 00 00    	add    $0x934a,%ebx
  freerange(vstart, vend);
8010317c:	83 ec 08             	sub    $0x8,%esp
8010317f:	ff 75 0c             	push   0xc(%ebp)
80103182:	ff 75 08             	push   0x8(%ebp)
80103185:	e8 13 00 00 00       	call   8010319d <freerange>
8010318a:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
8010318d:	c7 83 14 72 00 00 01 	movl   $0x1,0x7214(%ebx)
80103194:	00 00 00 
}
80103197:	90                   	nop
80103198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010319b:	c9                   	leave  
8010319c:	c3                   	ret    

8010319d <freerange>:

void
freerange(void *vstart, void *vend)
{
8010319d:	55                   	push   %ebp
8010319e:	89 e5                	mov    %esp,%ebp
801031a0:	83 ec 18             	sub    $0x18,%esp
801031a3:	e8 80 db ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801031a8:	05 18 93 00 00       	add    $0x9318,%eax
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801031ad:	8b 45 08             	mov    0x8(%ebp),%eax
801031b0:	05 ff 0f 00 00       	add    $0xfff,%eax
801031b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801031ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031bd:	eb 15                	jmp    801031d4 <freerange+0x37>
    kfree(p);
801031bf:	83 ec 0c             	sub    $0xc,%esp
801031c2:	ff 75 f4             	push   -0xc(%ebp)
801031c5:	e8 1b 00 00 00       	call   801031e5 <kfree>
801031ca:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031cd:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801031d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031d7:	05 00 10 00 00       	add    $0x1000,%eax
801031dc:	39 45 0c             	cmp    %eax,0xc(%ebp)
801031df:	73 de                	jae    801031bf <freerange+0x22>
}
801031e1:	90                   	nop
801031e2:	90                   	nop
801031e3:	c9                   	leave  
801031e4:	c3                   	ret    

801031e5 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801031e5:	55                   	push   %ebp
801031e6:	89 e5                	mov    %esp,%ebp
801031e8:	53                   	push   %ebx
801031e9:	83 ec 14             	sub    $0x14,%esp
801031ec:	e8 94 d1 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801031f1:	81 c3 cf 92 00 00    	add    $0x92cf,%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801031f7:	8b 45 08             	mov    0x8(%ebp),%eax
801031fa:	25 ff 0f 00 00       	and    $0xfff,%eax
801031ff:	85 c0                	test   %eax,%eax
80103201:	75 1a                	jne    8010321d <kfree+0x38>
80103203:	c7 c0 00 75 11 80    	mov    $0x80117500,%eax
80103209:	39 45 08             	cmp    %eax,0x8(%ebp)
8010320c:	72 0f                	jb     8010321d <kfree+0x38>
8010320e:	8b 45 08             	mov    0x8(%ebp),%eax
80103211:	05 00 00 00 80       	add    $0x80000000,%eax
80103216:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
8010321b:	76 0f                	jbe    8010322c <kfree+0x47>
    panic("kfree");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	8d 83 db d1 ff ff    	lea    -0x2e25(%ebx),%eax
80103226:	50                   	push   %eax
80103227:	e8 49 d4 ff ff       	call   80100675 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010322c:	83 ec 04             	sub    $0x4,%esp
8010322f:	68 00 10 00 00       	push   $0x1000
80103234:	6a 01                	push   $0x1
80103236:	ff 75 08             	push   0x8(%ebp)
80103239:	e8 b6 2b 00 00       	call   80105df4 <memset>
8010323e:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80103241:	8b 83 14 72 00 00    	mov    0x7214(%ebx),%eax
80103247:	85 c0                	test   %eax,%eax
80103249:	74 12                	je     8010325d <kfree+0x78>
    acquire(&kmem.lock);
8010324b:	83 ec 0c             	sub    $0xc,%esp
8010324e:	8d 83 e0 71 00 00    	lea    0x71e0(%ebx),%eax
80103254:	50                   	push   %eax
80103255:	e8 a8 28 00 00       	call   80105b02 <acquire>
8010325a:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
8010325d:	8b 45 08             	mov    0x8(%ebp),%eax
80103260:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80103263:	8b 93 18 72 00 00    	mov    0x7218(%ebx),%edx
80103269:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010326c:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
8010326e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103271:	89 83 18 72 00 00    	mov    %eax,0x7218(%ebx)
  if(kmem.use_lock)
80103277:	8b 83 14 72 00 00    	mov    0x7214(%ebx),%eax
8010327d:	85 c0                	test   %eax,%eax
8010327f:	74 12                	je     80103293 <kfree+0xae>
    release(&kmem.lock);
80103281:	83 ec 0c             	sub    $0xc,%esp
80103284:	8d 83 e0 71 00 00    	lea    0x71e0(%ebx),%eax
8010328a:	50                   	push   %eax
8010328b:	e8 ed 28 00 00       	call   80105b7d <release>
80103290:	83 c4 10             	add    $0x10,%esp
}
80103293:	90                   	nop
80103294:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103297:	c9                   	leave  
80103298:	c3                   	ret    

80103299 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103299:	55                   	push   %ebp
8010329a:	89 e5                	mov    %esp,%ebp
8010329c:	53                   	push   %ebx
8010329d:	83 ec 14             	sub    $0x14,%esp
801032a0:	e8 e0 d0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801032a5:	81 c3 1b 92 00 00    	add    $0x921b,%ebx
  struct run *r;

  if(kmem.use_lock)
801032ab:	8b 83 14 72 00 00    	mov    0x7214(%ebx),%eax
801032b1:	85 c0                	test   %eax,%eax
801032b3:	74 12                	je     801032c7 <kalloc+0x2e>
    acquire(&kmem.lock);
801032b5:	83 ec 0c             	sub    $0xc,%esp
801032b8:	8d 83 e0 71 00 00    	lea    0x71e0(%ebx),%eax
801032be:	50                   	push   %eax
801032bf:	e8 3e 28 00 00       	call   80105b02 <acquire>
801032c4:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
801032c7:	8b 83 18 72 00 00    	mov    0x7218(%ebx),%eax
801032cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
801032d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801032d4:	74 0b                	je     801032e1 <kalloc+0x48>
    kmem.freelist = r->next;
801032d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032d9:	8b 00                	mov    (%eax),%eax
801032db:	89 83 18 72 00 00    	mov    %eax,0x7218(%ebx)
  if(kmem.use_lock)
801032e1:	8b 83 14 72 00 00    	mov    0x7214(%ebx),%eax
801032e7:	85 c0                	test   %eax,%eax
801032e9:	74 12                	je     801032fd <kalloc+0x64>
    release(&kmem.lock);
801032eb:	83 ec 0c             	sub    $0xc,%esp
801032ee:	8d 83 e0 71 00 00    	lea    0x71e0(%ebx),%eax
801032f4:	50                   	push   %eax
801032f5:	e8 83 28 00 00       	call   80105b7d <release>
801032fa:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
801032fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103300:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103303:	c9                   	leave  
80103304:	c3                   	ret    

80103305 <inb>:
{
80103305:	55                   	push   %ebp
80103306:	89 e5                	mov    %esp,%ebp
80103308:	83 ec 14             	sub    $0x14,%esp
8010330b:	e8 18 da ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80103310:	05 b0 91 00 00       	add    $0x91b0,%eax
80103315:	8b 45 08             	mov    0x8(%ebp),%eax
80103318:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010331c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103320:	89 c2                	mov    %eax,%edx
80103322:	ec                   	in     (%dx),%al
80103323:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103326:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010332a:	c9                   	leave  
8010332b:	c3                   	ret    

8010332c <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
8010332c:	55                   	push   %ebp
8010332d:	89 e5                	mov    %esp,%ebp
8010332f:	53                   	push   %ebx
80103330:	83 ec 10             	sub    $0x10,%esp
80103333:	e8 4d d0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103338:	81 c3 88 91 00 00    	add    $0x9188,%ebx
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
8010333e:	6a 64                	push   $0x64
80103340:	e8 c0 ff ff ff       	call   80103305 <inb>
80103345:	83 c4 04             	add    $0x4,%esp
80103348:	0f b6 c0             	movzbl %al,%eax
8010334b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((st & KBS_DIB) == 0)
8010334e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103351:	83 e0 01             	and    $0x1,%eax
80103354:	85 c0                	test   %eax,%eax
80103356:	75 0a                	jne    80103362 <kbdgetc+0x36>
    return -1;
80103358:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010335d:	e9 3a 01 00 00       	jmp    8010349c <kbdgetc+0x170>
  data = inb(KBDATAP);
80103362:	6a 60                	push   $0x60
80103364:	e8 9c ff ff ff       	call   80103305 <inb>
80103369:	83 c4 04             	add    $0x4,%esp
8010336c:	0f b6 c0             	movzbl %al,%eax
8010336f:	89 45 f8             	mov    %eax,-0x8(%ebp)

  if(data == 0xE0){
80103372:	81 7d f8 e0 00 00 00 	cmpl   $0xe0,-0x8(%ebp)
80103379:	75 19                	jne    80103394 <kbdgetc+0x68>
    shift |= E0ESC;
8010337b:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103381:	83 c8 40             	or     $0x40,%eax
80103384:	89 83 1c 72 00 00    	mov    %eax,0x721c(%ebx)
    return 0;
8010338a:	b8 00 00 00 00       	mov    $0x0,%eax
8010338f:	e9 08 01 00 00       	jmp    8010349c <kbdgetc+0x170>
  } else if(data & 0x80){
80103394:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103397:	25 80 00 00 00       	and    $0x80,%eax
8010339c:	85 c0                	test   %eax,%eax
8010339e:	74 4b                	je     801033eb <kbdgetc+0xbf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801033a0:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
801033a6:	83 e0 40             	and    $0x40,%eax
801033a9:	85 c0                	test   %eax,%eax
801033ab:	75 08                	jne    801033b5 <kbdgetc+0x89>
801033ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
801033b0:	83 e0 7f             	and    $0x7f,%eax
801033b3:	eb 03                	jmp    801033b8 <kbdgetc+0x8c>
801033b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801033b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
801033bb:	8d 93 60 db ff ff    	lea    -0x24a0(%ebx),%edx
801033c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801033c4:	01 d0                	add    %edx,%eax
801033c6:	0f b6 00             	movzbl (%eax),%eax
801033c9:	83 c8 40             	or     $0x40,%eax
801033cc:	0f b6 c0             	movzbl %al,%eax
801033cf:	f7 d0                	not    %eax
801033d1:	89 c2                	mov    %eax,%edx
801033d3:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
801033d9:	21 d0                	and    %edx,%eax
801033db:	89 83 1c 72 00 00    	mov    %eax,0x721c(%ebx)
    return 0;
801033e1:	b8 00 00 00 00       	mov    $0x0,%eax
801033e6:	e9 b1 00 00 00       	jmp    8010349c <kbdgetc+0x170>
  } else if(shift & E0ESC){
801033eb:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
801033f1:	83 e0 40             	and    $0x40,%eax
801033f4:	85 c0                	test   %eax,%eax
801033f6:	74 16                	je     8010340e <kbdgetc+0xe2>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801033f8:	81 4d f8 80 00 00 00 	orl    $0x80,-0x8(%ebp)
    shift &= ~E0ESC;
801033ff:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103405:	83 e0 bf             	and    $0xffffffbf,%eax
80103408:	89 83 1c 72 00 00    	mov    %eax,0x721c(%ebx)
  }

  shift |= shiftcode[data];
8010340e:	8d 93 60 db ff ff    	lea    -0x24a0(%ebx),%edx
80103414:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103417:	01 d0                	add    %edx,%eax
80103419:	0f b6 00             	movzbl (%eax),%eax
8010341c:	0f b6 d0             	movzbl %al,%edx
8010341f:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103425:	09 d0                	or     %edx,%eax
80103427:	89 83 1c 72 00 00    	mov    %eax,0x721c(%ebx)
  shift ^= togglecode[data];
8010342d:	8d 93 60 dc ff ff    	lea    -0x23a0(%ebx),%edx
80103433:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103436:	01 d0                	add    %edx,%eax
80103438:	0f b6 00             	movzbl (%eax),%eax
8010343b:	0f b6 d0             	movzbl %al,%edx
8010343e:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103444:	31 d0                	xor    %edx,%eax
80103446:	89 83 1c 72 00 00    	mov    %eax,0x721c(%ebx)
  c = charcode[shift & (CTL | SHIFT)][data];
8010344c:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103452:	83 e0 03             	and    $0x3,%eax
80103455:	8b 94 83 0c 00 00 00 	mov    0xc(%ebx,%eax,4),%edx
8010345c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010345f:	01 d0                	add    %edx,%eax
80103461:	0f b6 00             	movzbl (%eax),%eax
80103464:	0f b6 c0             	movzbl %al,%eax
80103467:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(shift & CAPSLOCK){
8010346a:	8b 83 1c 72 00 00    	mov    0x721c(%ebx),%eax
80103470:	83 e0 08             	and    $0x8,%eax
80103473:	85 c0                	test   %eax,%eax
80103475:	74 22                	je     80103499 <kbdgetc+0x16d>
    if('a' <= c && c <= 'z')
80103477:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
8010347b:	76 0c                	jbe    80103489 <kbdgetc+0x15d>
8010347d:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
80103481:	77 06                	ja     80103489 <kbdgetc+0x15d>
      c += 'A' - 'a';
80103483:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
80103487:	eb 10                	jmp    80103499 <kbdgetc+0x16d>
    else if('A' <= c && c <= 'Z')
80103489:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
8010348d:	76 0a                	jbe    80103499 <kbdgetc+0x16d>
8010348f:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
80103493:	77 04                	ja     80103499 <kbdgetc+0x16d>
      c += 'a' - 'A';
80103495:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
  }
  return c;
80103499:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010349c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010349f:	c9                   	leave  
801034a0:	c3                   	ret    

801034a1 <kbdintr>:

void
kbdintr(void)
{
801034a1:	55                   	push   %ebp
801034a2:	89 e5                	mov    %esp,%ebp
801034a4:	53                   	push   %ebx
801034a5:	83 ec 04             	sub    $0x4,%esp
801034a8:	e8 7b d8 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801034ad:	05 13 90 00 00       	add    $0x9013,%eax
  consoleintr(kbdgetc);
801034b2:	83 ec 0c             	sub    $0xc,%esp
801034b5:	8d 90 6c 6e ff ff    	lea    -0x9194(%eax),%edx
801034bb:	52                   	push   %edx
801034bc:	89 c3                	mov    %eax,%ebx
801034be:	e8 80 d4 ff ff       	call   80100943 <consoleintr>
801034c3:	83 c4 10             	add    $0x10,%esp
}
801034c6:	90                   	nop
801034c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034ca:	c9                   	leave  
801034cb:	c3                   	ret    

801034cc <inb>:
{
801034cc:	55                   	push   %ebp
801034cd:	89 e5                	mov    %esp,%ebp
801034cf:	83 ec 14             	sub    $0x14,%esp
801034d2:	e8 51 d8 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801034d7:	05 e9 8f 00 00       	add    $0x8fe9,%eax
801034dc:	8b 45 08             	mov    0x8(%ebp),%eax
801034df:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034e3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801034e7:	89 c2                	mov    %eax,%edx
801034e9:	ec                   	in     (%dx),%al
801034ea:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801034ed:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801034f1:	c9                   	leave  
801034f2:	c3                   	ret    

801034f3 <outb>:
{
801034f3:	55                   	push   %ebp
801034f4:	89 e5                	mov    %esp,%ebp
801034f6:	83 ec 08             	sub    $0x8,%esp
801034f9:	e8 2a d8 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801034fe:	05 c2 8f 00 00       	add    $0x8fc2,%eax
80103503:	8b 45 08             	mov    0x8(%ebp),%eax
80103506:	8b 55 0c             	mov    0xc(%ebp),%edx
80103509:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010350d:	89 d0                	mov    %edx,%eax
8010350f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103512:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103516:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010351a:	ee                   	out    %al,(%dx)
}
8010351b:	90                   	nop
8010351c:	c9                   	leave  
8010351d:	c3                   	ret    

8010351e <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
8010351e:	55                   	push   %ebp
8010351f:	89 e5                	mov    %esp,%ebp
80103521:	e8 02 d8 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80103526:	05 9a 8f 00 00       	add    $0x8f9a,%eax
  lapic[index] = value;
8010352b:	8b 88 20 72 00 00    	mov    0x7220(%eax),%ecx
80103531:	8b 55 08             	mov    0x8(%ebp),%edx
80103534:	c1 e2 02             	shl    $0x2,%edx
80103537:	01 d1                	add    %edx,%ecx
80103539:	8b 55 0c             	mov    0xc(%ebp),%edx
8010353c:	89 11                	mov    %edx,(%ecx)
  lapic[ID];  // wait for write to finish, by reading
8010353e:	8b 80 20 72 00 00    	mov    0x7220(%eax),%eax
80103544:	83 c0 20             	add    $0x20,%eax
80103547:	8b 00                	mov    (%eax),%eax
}
80103549:	90                   	nop
8010354a:	5d                   	pop    %ebp
8010354b:	c3                   	ret    

8010354c <lapicinit>:

void
lapicinit(void)
{
8010354c:	55                   	push   %ebp
8010354d:	89 e5                	mov    %esp,%ebp
8010354f:	53                   	push   %ebx
80103550:	e8 30 ce ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103555:	81 c3 6b 8f 00 00    	add    $0x8f6b,%ebx
  if(!lapic)
8010355b:	8b 83 20 72 00 00    	mov    0x7220(%ebx),%eax
80103561:	85 c0                	test   %eax,%eax
80103563:	0f 84 0e 01 00 00    	je     80103677 <lapicinit+0x12b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103569:	68 3f 01 00 00       	push   $0x13f
8010356e:	6a 3c                	push   $0x3c
80103570:	e8 a9 ff ff ff       	call   8010351e <lapicw>
80103575:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103578:	6a 0b                	push   $0xb
8010357a:	68 f8 00 00 00       	push   $0xf8
8010357f:	e8 9a ff ff ff       	call   8010351e <lapicw>
80103584:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103587:	68 20 00 02 00       	push   $0x20020
8010358c:	68 c8 00 00 00       	push   $0xc8
80103591:	e8 88 ff ff ff       	call   8010351e <lapicw>
80103596:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80103599:	68 80 96 98 00       	push   $0x989680
8010359e:	68 e0 00 00 00       	push   $0xe0
801035a3:	e8 76 ff ff ff       	call   8010351e <lapicw>
801035a8:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
801035ab:	68 00 00 01 00       	push   $0x10000
801035b0:	68 d4 00 00 00       	push   $0xd4
801035b5:	e8 64 ff ff ff       	call   8010351e <lapicw>
801035ba:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
801035bd:	68 00 00 01 00       	push   $0x10000
801035c2:	68 d8 00 00 00       	push   $0xd8
801035c7:	e8 52 ff ff ff       	call   8010351e <lapicw>
801035cc:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801035cf:	8b 83 20 72 00 00    	mov    0x7220(%ebx),%eax
801035d5:	83 c0 30             	add    $0x30,%eax
801035d8:	8b 00                	mov    (%eax),%eax
801035da:	c1 e8 10             	shr    $0x10,%eax
801035dd:	25 fc 00 00 00       	and    $0xfc,%eax
801035e2:	85 c0                	test   %eax,%eax
801035e4:	74 12                	je     801035f8 <lapicinit+0xac>
    lapicw(PCINT, MASKED);
801035e6:	68 00 00 01 00       	push   $0x10000
801035eb:	68 d0 00 00 00       	push   $0xd0
801035f0:	e8 29 ff ff ff       	call   8010351e <lapicw>
801035f5:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801035f8:	6a 33                	push   $0x33
801035fa:	68 dc 00 00 00       	push   $0xdc
801035ff:	e8 1a ff ff ff       	call   8010351e <lapicw>
80103604:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103607:	6a 00                	push   $0x0
80103609:	68 a0 00 00 00       	push   $0xa0
8010360e:	e8 0b ff ff ff       	call   8010351e <lapicw>
80103613:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80103616:	6a 00                	push   $0x0
80103618:	68 a0 00 00 00       	push   $0xa0
8010361d:	e8 fc fe ff ff       	call   8010351e <lapicw>
80103622:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103625:	6a 00                	push   $0x0
80103627:	6a 2c                	push   $0x2c
80103629:	e8 f0 fe ff ff       	call   8010351e <lapicw>
8010362e:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80103631:	6a 00                	push   $0x0
80103633:	68 c4 00 00 00       	push   $0xc4
80103638:	e8 e1 fe ff ff       	call   8010351e <lapicw>
8010363d:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103640:	68 00 85 08 00       	push   $0x88500
80103645:	68 c0 00 00 00       	push   $0xc0
8010364a:	e8 cf fe ff ff       	call   8010351e <lapicw>
8010364f:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103652:	90                   	nop
80103653:	8b 83 20 72 00 00    	mov    0x7220(%ebx),%eax
80103659:	05 00 03 00 00       	add    $0x300,%eax
8010365e:	8b 00                	mov    (%eax),%eax
80103660:	25 00 10 00 00       	and    $0x1000,%eax
80103665:	85 c0                	test   %eax,%eax
80103667:	75 ea                	jne    80103653 <lapicinit+0x107>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103669:	6a 00                	push   $0x0
8010366b:	6a 20                	push   $0x20
8010366d:	e8 ac fe ff ff       	call   8010351e <lapicw>
80103672:	83 c4 08             	add    $0x8,%esp
80103675:	eb 01                	jmp    80103678 <lapicinit+0x12c>
    return;
80103677:	90                   	nop
}
80103678:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010367b:	c9                   	leave  
8010367c:	c3                   	ret    

8010367d <lapicid>:

int
lapicid(void)
{
8010367d:	55                   	push   %ebp
8010367e:	89 e5                	mov    %esp,%ebp
80103680:	e8 a3 d6 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80103685:	05 3b 8e 00 00       	add    $0x8e3b,%eax
  if (!lapic)
8010368a:	8b 90 20 72 00 00    	mov    0x7220(%eax),%edx
80103690:	85 d2                	test   %edx,%edx
80103692:	75 07                	jne    8010369b <lapicid+0x1e>
    return 0;
80103694:	b8 00 00 00 00       	mov    $0x0,%eax
80103699:	eb 0e                	jmp    801036a9 <lapicid+0x2c>
  return lapic[ID] >> 24;
8010369b:	8b 80 20 72 00 00    	mov    0x7220(%eax),%eax
801036a1:	83 c0 20             	add    $0x20,%eax
801036a4:	8b 00                	mov    (%eax),%eax
801036a6:	c1 e8 18             	shr    $0x18,%eax
}
801036a9:	5d                   	pop    %ebp
801036aa:	c3                   	ret    

801036ab <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801036ab:	55                   	push   %ebp
801036ac:	89 e5                	mov    %esp,%ebp
801036ae:	e8 75 d6 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801036b3:	05 0d 8e 00 00       	add    $0x8e0d,%eax
  if(lapic)
801036b8:	8b 80 20 72 00 00    	mov    0x7220(%eax),%eax
801036be:	85 c0                	test   %eax,%eax
801036c0:	74 0c                	je     801036ce <lapiceoi+0x23>
    lapicw(EOI, 0);
801036c2:	6a 00                	push   $0x0
801036c4:	6a 2c                	push   $0x2c
801036c6:	e8 53 fe ff ff       	call   8010351e <lapicw>
801036cb:	83 c4 08             	add    $0x8,%esp
}
801036ce:	90                   	nop
801036cf:	c9                   	leave  
801036d0:	c3                   	ret    

801036d1 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801036d1:	55                   	push   %ebp
801036d2:	89 e5                	mov    %esp,%ebp
801036d4:	e8 4f d6 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801036d9:	05 e7 8d 00 00       	add    $0x8de7,%eax
}
801036de:	90                   	nop
801036df:	5d                   	pop    %ebp
801036e0:	c3                   	ret    

801036e1 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801036e1:	55                   	push   %ebp
801036e2:	89 e5                	mov    %esp,%ebp
801036e4:	83 ec 14             	sub    $0x14,%esp
801036e7:	e8 3c d6 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801036ec:	05 d4 8d 00 00       	add    $0x8dd4,%eax
801036f1:	8b 45 08             	mov    0x8(%ebp),%eax
801036f4:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
801036f7:	6a 0f                	push   $0xf
801036f9:	6a 70                	push   $0x70
801036fb:	e8 f3 fd ff ff       	call   801034f3 <outb>
80103700:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103703:	6a 0a                	push   $0xa
80103705:	6a 71                	push   $0x71
80103707:	e8 e7 fd ff ff       	call   801034f3 <outb>
8010370c:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
8010370f:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103716:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103719:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010371e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103721:	c1 e8 04             	shr    $0x4,%eax
80103724:	89 c2                	mov    %eax,%edx
80103726:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103729:	83 c0 02             	add    $0x2,%eax
8010372c:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010372f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103733:	c1 e0 18             	shl    $0x18,%eax
80103736:	50                   	push   %eax
80103737:	68 c4 00 00 00       	push   $0xc4
8010373c:	e8 dd fd ff ff       	call   8010351e <lapicw>
80103741:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103744:	68 00 c5 00 00       	push   $0xc500
80103749:	68 c0 00 00 00       	push   $0xc0
8010374e:	e8 cb fd ff ff       	call   8010351e <lapicw>
80103753:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103756:	68 c8 00 00 00       	push   $0xc8
8010375b:	e8 71 ff ff ff       	call   801036d1 <microdelay>
80103760:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103763:	68 00 85 00 00       	push   $0x8500
80103768:	68 c0 00 00 00       	push   $0xc0
8010376d:	e8 ac fd ff ff       	call   8010351e <lapicw>
80103772:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103775:	6a 64                	push   $0x64
80103777:	e8 55 ff ff ff       	call   801036d1 <microdelay>
8010377c:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010377f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103786:	eb 3d                	jmp    801037c5 <lapicstartap+0xe4>
    lapicw(ICRHI, apicid<<24);
80103788:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010378c:	c1 e0 18             	shl    $0x18,%eax
8010378f:	50                   	push   %eax
80103790:	68 c4 00 00 00       	push   $0xc4
80103795:	e8 84 fd ff ff       	call   8010351e <lapicw>
8010379a:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010379d:	8b 45 0c             	mov    0xc(%ebp),%eax
801037a0:	c1 e8 0c             	shr    $0xc,%eax
801037a3:	80 cc 06             	or     $0x6,%ah
801037a6:	50                   	push   %eax
801037a7:	68 c0 00 00 00       	push   $0xc0
801037ac:	e8 6d fd ff ff       	call   8010351e <lapicw>
801037b1:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801037b4:	68 c8 00 00 00       	push   $0xc8
801037b9:	e8 13 ff ff ff       	call   801036d1 <microdelay>
801037be:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
801037c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801037c5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801037c9:	7e bd                	jle    80103788 <lapicstartap+0xa7>
  }
}
801037cb:	90                   	nop
801037cc:	90                   	nop
801037cd:	c9                   	leave  
801037ce:	c3                   	ret    

801037cf <cmos_read>:
#define MONTH   0x08
#define YEAR    0x09

static uint
cmos_read(uint reg)
{
801037cf:	55                   	push   %ebp
801037d0:	89 e5                	mov    %esp,%ebp
801037d2:	e8 51 d5 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801037d7:	05 e9 8c 00 00       	add    $0x8ce9,%eax
  outb(CMOS_PORT,  reg);
801037dc:	8b 45 08             	mov    0x8(%ebp),%eax
801037df:	0f b6 c0             	movzbl %al,%eax
801037e2:	50                   	push   %eax
801037e3:	6a 70                	push   $0x70
801037e5:	e8 09 fd ff ff       	call   801034f3 <outb>
801037ea:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801037ed:	68 c8 00 00 00       	push   $0xc8
801037f2:	e8 da fe ff ff       	call   801036d1 <microdelay>
801037f7:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
801037fa:	6a 71                	push   $0x71
801037fc:	e8 cb fc ff ff       	call   801034cc <inb>
80103801:	83 c4 04             	add    $0x4,%esp
80103804:	0f b6 c0             	movzbl %al,%eax
}
80103807:	c9                   	leave  
80103808:	c3                   	ret    

80103809 <fill_rtcdate>:

static void
fill_rtcdate(struct rtcdate *r)
{
80103809:	55                   	push   %ebp
8010380a:	89 e5                	mov    %esp,%ebp
8010380c:	e8 17 d5 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80103811:	05 af 8c 00 00       	add    $0x8caf,%eax
  r->second = cmos_read(SECS);
80103816:	6a 00                	push   $0x0
80103818:	e8 b2 ff ff ff       	call   801037cf <cmos_read>
8010381d:	83 c4 04             	add    $0x4,%esp
80103820:	8b 55 08             	mov    0x8(%ebp),%edx
80103823:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
80103825:	6a 02                	push   $0x2
80103827:	e8 a3 ff ff ff       	call   801037cf <cmos_read>
8010382c:	83 c4 04             	add    $0x4,%esp
8010382f:	8b 55 08             	mov    0x8(%ebp),%edx
80103832:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80103835:	6a 04                	push   $0x4
80103837:	e8 93 ff ff ff       	call   801037cf <cmos_read>
8010383c:	83 c4 04             	add    $0x4,%esp
8010383f:	8b 55 08             	mov    0x8(%ebp),%edx
80103842:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
80103845:	6a 07                	push   $0x7
80103847:	e8 83 ff ff ff       	call   801037cf <cmos_read>
8010384c:	83 c4 04             	add    $0x4,%esp
8010384f:	8b 55 08             	mov    0x8(%ebp),%edx
80103852:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
80103855:	6a 08                	push   $0x8
80103857:	e8 73 ff ff ff       	call   801037cf <cmos_read>
8010385c:	83 c4 04             	add    $0x4,%esp
8010385f:	8b 55 08             	mov    0x8(%ebp),%edx
80103862:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
80103865:	6a 09                	push   $0x9
80103867:	e8 63 ff ff ff       	call   801037cf <cmos_read>
8010386c:	83 c4 04             	add    $0x4,%esp
8010386f:	8b 55 08             	mov    0x8(%ebp),%edx
80103872:	89 42 14             	mov    %eax,0x14(%edx)
}
80103875:	90                   	nop
80103876:	c9                   	leave  
80103877:	c3                   	ret    

80103878 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103878:	55                   	push   %ebp
80103879:	89 e5                	mov    %esp,%ebp
8010387b:	53                   	push   %ebx
8010387c:	83 ec 44             	sub    $0x44,%esp
8010387f:	e8 01 cb ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103884:	81 c3 3c 8c 00 00    	add    $0x8c3c,%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
8010388a:	6a 0b                	push   $0xb
8010388c:	e8 3e ff ff ff       	call   801037cf <cmos_read>
80103891:	83 c4 04             	add    $0x4,%esp
80103894:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103897:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010389a:	83 e0 04             	and    $0x4,%eax
8010389d:	85 c0                	test   %eax,%eax
8010389f:	0f 94 c0             	sete   %al
801038a2:	0f b6 c0             	movzbl %al,%eax
801038a5:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801038a8:	8d 45 d8             	lea    -0x28(%ebp),%eax
801038ab:	50                   	push   %eax
801038ac:	e8 58 ff ff ff       	call   80103809 <fill_rtcdate>
801038b1:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801038b4:	6a 0a                	push   $0xa
801038b6:	e8 14 ff ff ff       	call   801037cf <cmos_read>
801038bb:	83 c4 04             	add    $0x4,%esp
801038be:	25 80 00 00 00       	and    $0x80,%eax
801038c3:	85 c0                	test   %eax,%eax
801038c5:	75 27                	jne    801038ee <cmostime+0x76>
        continue;
    fill_rtcdate(&t2);
801038c7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801038ca:	50                   	push   %eax
801038cb:	e8 39 ff ff ff       	call   80103809 <fill_rtcdate>
801038d0:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801038d3:	83 ec 04             	sub    $0x4,%esp
801038d6:	6a 18                	push   $0x18
801038d8:	8d 45 c0             	lea    -0x40(%ebp),%eax
801038db:	50                   	push   %eax
801038dc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801038df:	50                   	push   %eax
801038e0:	e8 80 25 00 00       	call   80105e65 <memcmp>
801038e5:	83 c4 10             	add    $0x10,%esp
801038e8:	85 c0                	test   %eax,%eax
801038ea:	74 05                	je     801038f1 <cmostime+0x79>
801038ec:	eb ba                	jmp    801038a8 <cmostime+0x30>
        continue;
801038ee:	90                   	nop
    fill_rtcdate(&t1);
801038ef:	eb b7                	jmp    801038a8 <cmostime+0x30>
      break;
801038f1:	90                   	nop
  }

  // convert
  if(bcd) {
801038f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801038f6:	0f 84 b4 00 00 00    	je     801039b0 <cmostime+0x138>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801038fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
801038ff:	c1 e8 04             	shr    $0x4,%eax
80103902:	89 c2                	mov    %eax,%edx
80103904:	89 d0                	mov    %edx,%eax
80103906:	c1 e0 02             	shl    $0x2,%eax
80103909:	01 d0                	add    %edx,%eax
8010390b:	01 c0                	add    %eax,%eax
8010390d:	89 c2                	mov    %eax,%edx
8010390f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103912:	83 e0 0f             	and    $0xf,%eax
80103915:	01 d0                	add    %edx,%eax
80103917:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
8010391a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010391d:	c1 e8 04             	shr    $0x4,%eax
80103920:	89 c2                	mov    %eax,%edx
80103922:	89 d0                	mov    %edx,%eax
80103924:	c1 e0 02             	shl    $0x2,%eax
80103927:	01 d0                	add    %edx,%eax
80103929:	01 c0                	add    %eax,%eax
8010392b:	89 c2                	mov    %eax,%edx
8010392d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103930:	83 e0 0f             	and    $0xf,%eax
80103933:	01 d0                	add    %edx,%eax
80103935:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103938:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010393b:	c1 e8 04             	shr    $0x4,%eax
8010393e:	89 c2                	mov    %eax,%edx
80103940:	89 d0                	mov    %edx,%eax
80103942:	c1 e0 02             	shl    $0x2,%eax
80103945:	01 d0                	add    %edx,%eax
80103947:	01 c0                	add    %eax,%eax
80103949:	89 c2                	mov    %eax,%edx
8010394b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010394e:	83 e0 0f             	and    $0xf,%eax
80103951:	01 d0                	add    %edx,%eax
80103953:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
80103956:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103959:	c1 e8 04             	shr    $0x4,%eax
8010395c:	89 c2                	mov    %eax,%edx
8010395e:	89 d0                	mov    %edx,%eax
80103960:	c1 e0 02             	shl    $0x2,%eax
80103963:	01 d0                	add    %edx,%eax
80103965:	01 c0                	add    %eax,%eax
80103967:	89 c2                	mov    %eax,%edx
80103969:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010396c:	83 e0 0f             	and    $0xf,%eax
8010396f:	01 d0                	add    %edx,%eax
80103971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
80103974:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103977:	c1 e8 04             	shr    $0x4,%eax
8010397a:	89 c2                	mov    %eax,%edx
8010397c:	89 d0                	mov    %edx,%eax
8010397e:	c1 e0 02             	shl    $0x2,%eax
80103981:	01 d0                	add    %edx,%eax
80103983:	01 c0                	add    %eax,%eax
80103985:	89 c2                	mov    %eax,%edx
80103987:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010398a:	83 e0 0f             	and    $0xf,%eax
8010398d:	01 d0                	add    %edx,%eax
8010398f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
80103992:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103995:	c1 e8 04             	shr    $0x4,%eax
80103998:	89 c2                	mov    %eax,%edx
8010399a:	89 d0                	mov    %edx,%eax
8010399c:	c1 e0 02             	shl    $0x2,%eax
8010399f:	01 d0                	add    %edx,%eax
801039a1:	01 c0                	add    %eax,%eax
801039a3:	89 c2                	mov    %eax,%edx
801039a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801039a8:	83 e0 0f             	and    $0xf,%eax
801039ab:	01 d0                	add    %edx,%eax
801039ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
801039b0:	8b 45 08             	mov    0x8(%ebp),%eax
801039b3:	8b 55 d8             	mov    -0x28(%ebp),%edx
801039b6:	89 10                	mov    %edx,(%eax)
801039b8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801039bb:	89 50 04             	mov    %edx,0x4(%eax)
801039be:	8b 55 e0             	mov    -0x20(%ebp),%edx
801039c1:	89 50 08             	mov    %edx,0x8(%eax)
801039c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039c7:	89 50 0c             	mov    %edx,0xc(%eax)
801039ca:	8b 55 e8             	mov    -0x18(%ebp),%edx
801039cd:	89 50 10             	mov    %edx,0x10(%eax)
801039d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039d3:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801039d6:	8b 45 08             	mov    0x8(%ebp),%eax
801039d9:	8b 40 14             	mov    0x14(%eax),%eax
801039dc:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801039e2:	8b 45 08             	mov    0x8(%ebp),%eax
801039e5:	89 50 14             	mov    %edx,0x14(%eax)
}
801039e8:	90                   	nop
801039e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ec:	c9                   	leave  
801039ed:	c3                   	ret    

801039ee <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801039ee:	55                   	push   %ebp
801039ef:	89 e5                	mov    %esp,%ebp
801039f1:	53                   	push   %ebx
801039f2:	83 ec 24             	sub    $0x24,%esp
801039f5:	e8 8b c9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801039fa:	81 c3 c6 8a 00 00    	add    $0x8ac6,%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103a00:	83 ec 08             	sub    $0x8,%esp
80103a03:	8d 83 e1 d1 ff ff    	lea    -0x2e1f(%ebx),%eax
80103a09:	50                   	push   %eax
80103a0a:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103a10:	50                   	push   %eax
80103a11:	e8 c0 20 00 00       	call   80105ad6 <initlock>
80103a16:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80103a19:	83 ec 08             	sub    $0x8,%esp
80103a1c:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103a1f:	50                   	push   %eax
80103a20:	ff 75 08             	push   0x8(%ebp)
80103a23:	e8 15 dd ff ff       	call   8010173d <readsb>
80103a28:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103a2b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103a2e:	89 83 74 72 00 00    	mov    %eax,0x7274(%ebx)
  log.size = sb.nlog;
80103a34:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103a37:	89 83 78 72 00 00    	mov    %eax,0x7278(%ebx)
  log.dev = dev;
80103a3d:	8b 45 08             	mov    0x8(%ebp),%eax
80103a40:	89 83 84 72 00 00    	mov    %eax,0x7284(%ebx)
  recover_from_log();
80103a46:	e8 ed 01 00 00       	call   80103c38 <recover_from_log>
}
80103a4b:	90                   	nop
80103a4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a4f:	c9                   	leave  
80103a50:	c3                   	ret    

80103a51 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103a51:	55                   	push   %ebp
80103a52:	89 e5                	mov    %esp,%ebp
80103a54:	53                   	push   %ebx
80103a55:	83 ec 14             	sub    $0x14,%esp
80103a58:	e8 28 c9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103a5d:	81 c3 63 8a 00 00    	add    $0x8a63,%ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103a63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103a6a:	e9 97 00 00 00       	jmp    80103b06 <install_trans+0xb5>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103a6f:	8b 93 74 72 00 00    	mov    0x7274(%ebx),%edx
80103a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a78:	01 d0                	add    %edx,%eax
80103a7a:	83 c0 01             	add    $0x1,%eax
80103a7d:	89 c2                	mov    %eax,%edx
80103a7f:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103a85:	83 ec 08             	sub    $0x8,%esp
80103a88:	52                   	push   %edx
80103a89:	50                   	push   %eax
80103a8a:	e8 7d c7 ff ff       	call   8010020c <bread>
80103a8f:	83 c4 10             	add    $0x10,%esp
80103a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a98:	83 c0 10             	add    $0x10,%eax
80103a9b:	8b 84 83 4c 72 00 00 	mov    0x724c(%ebx,%eax,4),%eax
80103aa2:	89 c2                	mov    %eax,%edx
80103aa4:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103aaa:	83 ec 08             	sub    $0x8,%esp
80103aad:	52                   	push   %edx
80103aae:	50                   	push   %eax
80103aaf:	e8 58 c7 ff ff       	call   8010020c <bread>
80103ab4:	83 c4 10             	add    $0x10,%esp
80103ab7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103aba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103abd:	8d 50 5c             	lea    0x5c(%eax),%edx
80103ac0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103ac3:	83 c0 5c             	add    $0x5c,%eax
80103ac6:	83 ec 04             	sub    $0x4,%esp
80103ac9:	68 00 02 00 00       	push   $0x200
80103ace:	52                   	push   %edx
80103acf:	50                   	push   %eax
80103ad0:	e8 f2 23 00 00       	call   80105ec7 <memmove>
80103ad5:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103ad8:	83 ec 0c             	sub    $0xc,%esp
80103adb:	ff 75 ec             	push   -0x14(%ebp)
80103ade:	e8 71 c7 ff ff       	call   80100254 <bwrite>
80103ae3:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
80103ae6:	83 ec 0c             	sub    $0xc,%esp
80103ae9:	ff 75 f0             	push   -0x10(%ebp)
80103aec:	e8 bd c7 ff ff       	call   801002ae <brelse>
80103af1:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80103af4:	83 ec 0c             	sub    $0xc,%esp
80103af7:	ff 75 ec             	push   -0x14(%ebp)
80103afa:	e8 af c7 ff ff       	call   801002ae <brelse>
80103aff:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103b02:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103b06:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103b0c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103b0f:	0f 8c 5a ff ff ff    	jl     80103a6f <install_trans+0x1e>
  }
}
80103b15:	90                   	nop
80103b16:	90                   	nop
80103b17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b1a:	c9                   	leave  
80103b1b:	c3                   	ret    

80103b1c <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103b1c:	55                   	push   %ebp
80103b1d:	89 e5                	mov    %esp,%ebp
80103b1f:	53                   	push   %ebx
80103b20:	83 ec 14             	sub    $0x14,%esp
80103b23:	e8 5d c8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103b28:	81 c3 98 89 00 00    	add    $0x8998,%ebx
  struct buf *buf = bread(log.dev, log.start);
80103b2e:	8b 83 74 72 00 00    	mov    0x7274(%ebx),%eax
80103b34:	89 c2                	mov    %eax,%edx
80103b36:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103b3c:	83 ec 08             	sub    $0x8,%esp
80103b3f:	52                   	push   %edx
80103b40:	50                   	push   %eax
80103b41:	e8 c6 c6 ff ff       	call   8010020c <bread>
80103b46:	83 c4 10             	add    $0x10,%esp
80103b49:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103b4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b4f:	83 c0 5c             	add    $0x5c,%eax
80103b52:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103b55:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b58:	8b 00                	mov    (%eax),%eax
80103b5a:	89 83 88 72 00 00    	mov    %eax,0x7288(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103b60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103b67:	eb 1b                	jmp    80103b84 <read_head+0x68>
    log.lh.block[i] = lh->block[i];
80103b69:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b6f:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103b73:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103b76:	83 c2 10             	add    $0x10,%edx
80103b79:	89 84 93 4c 72 00 00 	mov    %eax,0x724c(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103b80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103b84:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103b8a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103b8d:	7c da                	jl     80103b69 <read_head+0x4d>
  }
  brelse(buf);
80103b8f:	83 ec 0c             	sub    $0xc,%esp
80103b92:	ff 75 f0             	push   -0x10(%ebp)
80103b95:	e8 14 c7 ff ff       	call   801002ae <brelse>
80103b9a:	83 c4 10             	add    $0x10,%esp
}
80103b9d:	90                   	nop
80103b9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ba1:	c9                   	leave  
80103ba2:	c3                   	ret    

80103ba3 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103ba3:	55                   	push   %ebp
80103ba4:	89 e5                	mov    %esp,%ebp
80103ba6:	53                   	push   %ebx
80103ba7:	83 ec 14             	sub    $0x14,%esp
80103baa:	e8 d6 c7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103baf:	81 c3 11 89 00 00    	add    $0x8911,%ebx
  struct buf *buf = bread(log.dev, log.start);
80103bb5:	8b 83 74 72 00 00    	mov    0x7274(%ebx),%eax
80103bbb:	89 c2                	mov    %eax,%edx
80103bbd:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103bc3:	83 ec 08             	sub    $0x8,%esp
80103bc6:	52                   	push   %edx
80103bc7:	50                   	push   %eax
80103bc8:	e8 3f c6 ff ff       	call   8010020c <bread>
80103bcd:	83 c4 10             	add    $0x10,%esp
80103bd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bd6:	83 c0 5c             	add    $0x5c,%eax
80103bd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103bdc:	8b 93 88 72 00 00    	mov    0x7288(%ebx),%edx
80103be2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103be5:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103be7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103bee:	eb 1b                	jmp    80103c0b <write_head+0x68>
    hb->block[i] = log.lh.block[i];
80103bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bf3:	83 c0 10             	add    $0x10,%eax
80103bf6:	8b 8c 83 4c 72 00 00 	mov    0x724c(%ebx,%eax,4),%ecx
80103bfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c00:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c03:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103c07:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103c0b:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103c11:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103c14:	7c da                	jl     80103bf0 <write_head+0x4d>
  }
  bwrite(buf);
80103c16:	83 ec 0c             	sub    $0xc,%esp
80103c19:	ff 75 f0             	push   -0x10(%ebp)
80103c1c:	e8 33 c6 ff ff       	call   80100254 <bwrite>
80103c21:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103c24:	83 ec 0c             	sub    $0xc,%esp
80103c27:	ff 75 f0             	push   -0x10(%ebp)
80103c2a:	e8 7f c6 ff ff       	call   801002ae <brelse>
80103c2f:	83 c4 10             	add    $0x10,%esp
}
80103c32:	90                   	nop
80103c33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c36:	c9                   	leave  
80103c37:	c3                   	ret    

80103c38 <recover_from_log>:

static void
recover_from_log(void)
{
80103c38:	55                   	push   %ebp
80103c39:	89 e5                	mov    %esp,%ebp
80103c3b:	53                   	push   %ebx
80103c3c:	83 ec 04             	sub    $0x4,%esp
80103c3f:	e8 41 c7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103c44:	81 c3 7c 88 00 00    	add    $0x887c,%ebx
  read_head();
80103c4a:	e8 cd fe ff ff       	call   80103b1c <read_head>
  install_trans(); // if committed, copy from log to disk
80103c4f:	e8 fd fd ff ff       	call   80103a51 <install_trans>
  log.lh.n = 0;
80103c54:	c7 83 88 72 00 00 00 	movl   $0x0,0x7288(%ebx)
80103c5b:	00 00 00 
  write_head(); // clear the log
80103c5e:	e8 40 ff ff ff       	call   80103ba3 <write_head>
}
80103c63:	90                   	nop
80103c64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c67:	c9                   	leave  
80103c68:	c3                   	ret    

80103c69 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103c69:	55                   	push   %ebp
80103c6a:	89 e5                	mov    %esp,%ebp
80103c6c:	53                   	push   %ebx
80103c6d:	83 ec 04             	sub    $0x4,%esp
80103c70:	e8 10 c7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103c75:	81 c3 4b 88 00 00    	add    $0x884b,%ebx
  acquire(&log.lock);
80103c7b:	83 ec 0c             	sub    $0xc,%esp
80103c7e:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103c84:	50                   	push   %eax
80103c85:	e8 78 1e 00 00       	call   80105b02 <acquire>
80103c8a:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103c8d:	8b 83 80 72 00 00    	mov    0x7280(%ebx),%eax
80103c93:	85 c0                	test   %eax,%eax
80103c95:	74 1b                	je     80103cb2 <begin_op+0x49>
      sleep(&log, &log.lock);
80103c97:	83 ec 08             	sub    $0x8,%esp
80103c9a:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103ca0:	50                   	push   %eax
80103ca1:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103ca7:	50                   	push   %eax
80103ca8:	e8 8f 18 00 00       	call   8010553c <sleep>
80103cad:	83 c4 10             	add    $0x10,%esp
80103cb0:	eb db                	jmp    80103c8d <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103cb2:	8b 8b 88 72 00 00    	mov    0x7288(%ebx),%ecx
80103cb8:	8b 83 7c 72 00 00    	mov    0x727c(%ebx),%eax
80103cbe:	8d 50 01             	lea    0x1(%eax),%edx
80103cc1:	89 d0                	mov    %edx,%eax
80103cc3:	c1 e0 02             	shl    $0x2,%eax
80103cc6:	01 d0                	add    %edx,%eax
80103cc8:	01 c0                	add    %eax,%eax
80103cca:	01 c8                	add    %ecx,%eax
80103ccc:	83 f8 1e             	cmp    $0x1e,%eax
80103ccf:	7e 1b                	jle    80103cec <begin_op+0x83>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103cd1:	83 ec 08             	sub    $0x8,%esp
80103cd4:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103cda:	50                   	push   %eax
80103cdb:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103ce1:	50                   	push   %eax
80103ce2:	e8 55 18 00 00       	call   8010553c <sleep>
80103ce7:	83 c4 10             	add    $0x10,%esp
80103cea:	eb a1                	jmp    80103c8d <begin_op+0x24>
    } else {
      log.outstanding += 1;
80103cec:	8b 83 7c 72 00 00    	mov    0x727c(%ebx),%eax
80103cf2:	83 c0 01             	add    $0x1,%eax
80103cf5:	89 83 7c 72 00 00    	mov    %eax,0x727c(%ebx)
      release(&log.lock);
80103cfb:	83 ec 0c             	sub    $0xc,%esp
80103cfe:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103d04:	50                   	push   %eax
80103d05:	e8 73 1e 00 00       	call   80105b7d <release>
80103d0a:	83 c4 10             	add    $0x10,%esp
      break;
80103d0d:	90                   	nop
    }
  }
}
80103d0e:	90                   	nop
80103d0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d12:	c9                   	leave  
80103d13:	c3                   	ret    

80103d14 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103d14:	55                   	push   %ebp
80103d15:	89 e5                	mov    %esp,%ebp
80103d17:	53                   	push   %ebx
80103d18:	83 ec 14             	sub    $0x14,%esp
80103d1b:	e8 65 c6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103d20:	81 c3 a0 87 00 00    	add    $0x87a0,%ebx
  int do_commit = 0;
80103d26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103d36:	50                   	push   %eax
80103d37:	e8 c6 1d 00 00       	call   80105b02 <acquire>
80103d3c:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103d3f:	8b 83 7c 72 00 00    	mov    0x727c(%ebx),%eax
80103d45:	83 e8 01             	sub    $0x1,%eax
80103d48:	89 83 7c 72 00 00    	mov    %eax,0x727c(%ebx)
  if(log.committing)
80103d4e:	8b 83 80 72 00 00    	mov    0x7280(%ebx),%eax
80103d54:	85 c0                	test   %eax,%eax
80103d56:	74 0f                	je     80103d67 <end_op+0x53>
    panic("log.committing");
80103d58:	83 ec 0c             	sub    $0xc,%esp
80103d5b:	8d 83 e5 d1 ff ff    	lea    -0x2e1b(%ebx),%eax
80103d61:	50                   	push   %eax
80103d62:	e8 0e c9 ff ff       	call   80100675 <panic>
  if(log.outstanding == 0){
80103d67:	8b 83 7c 72 00 00    	mov    0x727c(%ebx),%eax
80103d6d:	85 c0                	test   %eax,%eax
80103d6f:	75 13                	jne    80103d84 <end_op+0x70>
    do_commit = 1;
80103d71:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103d78:	c7 83 80 72 00 00 01 	movl   $0x1,0x7280(%ebx)
80103d7f:	00 00 00 
80103d82:	eb 12                	jmp    80103d96 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80103d84:	83 ec 0c             	sub    $0xc,%esp
80103d87:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103d8d:	50                   	push   %eax
80103d8e:	e8 b9 18 00 00       	call   8010564c <wakeup>
80103d93:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
80103d96:	83 ec 0c             	sub    $0xc,%esp
80103d99:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103d9f:	50                   	push   %eax
80103da0:	e8 d8 1d 00 00       	call   80105b7d <release>
80103da5:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
80103da8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103dac:	74 45                	je     80103df3 <end_op+0xdf>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103dae:	e8 11 01 00 00       	call   80103ec4 <commit>
    acquire(&log.lock);
80103db3:	83 ec 0c             	sub    $0xc,%esp
80103db6:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103dbc:	50                   	push   %eax
80103dbd:	e8 40 1d 00 00       	call   80105b02 <acquire>
80103dc2:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103dc5:	c7 83 80 72 00 00 00 	movl   $0x0,0x7280(%ebx)
80103dcc:	00 00 00 
    wakeup(&log);
80103dcf:	83 ec 0c             	sub    $0xc,%esp
80103dd2:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103dd8:	50                   	push   %eax
80103dd9:	e8 6e 18 00 00       	call   8010564c <wakeup>
80103dde:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
80103de1:	83 ec 0c             	sub    $0xc,%esp
80103de4:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103dea:	50                   	push   %eax
80103deb:	e8 8d 1d 00 00       	call   80105b7d <release>
80103df0:	83 c4 10             	add    $0x10,%esp
  }
}
80103df3:	90                   	nop
80103df4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103df7:	c9                   	leave  
80103df8:	c3                   	ret    

80103df9 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103df9:	55                   	push   %ebp
80103dfa:	89 e5                	mov    %esp,%ebp
80103dfc:	53                   	push   %ebx
80103dfd:	83 ec 14             	sub    $0x14,%esp
80103e00:	e8 80 c5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103e05:	81 c3 bb 86 00 00    	add    $0x86bb,%ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103e0b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103e12:	e9 97 00 00 00       	jmp    80103eae <write_log+0xb5>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103e17:	8b 93 74 72 00 00    	mov    0x7274(%ebx),%edx
80103e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e20:	01 d0                	add    %edx,%eax
80103e22:	83 c0 01             	add    $0x1,%eax
80103e25:	89 c2                	mov    %eax,%edx
80103e27:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103e2d:	83 ec 08             	sub    $0x8,%esp
80103e30:	52                   	push   %edx
80103e31:	50                   	push   %eax
80103e32:	e8 d5 c3 ff ff       	call   8010020c <bread>
80103e37:	83 c4 10             	add    $0x10,%esp
80103e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e40:	83 c0 10             	add    $0x10,%eax
80103e43:	8b 84 83 4c 72 00 00 	mov    0x724c(%ebx,%eax,4),%eax
80103e4a:	89 c2                	mov    %eax,%edx
80103e4c:	8b 83 84 72 00 00    	mov    0x7284(%ebx),%eax
80103e52:	83 ec 08             	sub    $0x8,%esp
80103e55:	52                   	push   %edx
80103e56:	50                   	push   %eax
80103e57:	e8 b0 c3 ff ff       	call   8010020c <bread>
80103e5c:	83 c4 10             	add    $0x10,%esp
80103e5f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80103e62:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103e65:	8d 50 5c             	lea    0x5c(%eax),%edx
80103e68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103e6b:	83 c0 5c             	add    $0x5c,%eax
80103e6e:	83 ec 04             	sub    $0x4,%esp
80103e71:	68 00 02 00 00       	push   $0x200
80103e76:	52                   	push   %edx
80103e77:	50                   	push   %eax
80103e78:	e8 4a 20 00 00       	call   80105ec7 <memmove>
80103e7d:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
80103e80:	83 ec 0c             	sub    $0xc,%esp
80103e83:	ff 75 f0             	push   -0x10(%ebp)
80103e86:	e8 c9 c3 ff ff       	call   80100254 <bwrite>
80103e8b:	83 c4 10             	add    $0x10,%esp
    brelse(from);
80103e8e:	83 ec 0c             	sub    $0xc,%esp
80103e91:	ff 75 ec             	push   -0x14(%ebp)
80103e94:	e8 15 c4 ff ff       	call   801002ae <brelse>
80103e99:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103e9c:	83 ec 0c             	sub    $0xc,%esp
80103e9f:	ff 75 f0             	push   -0x10(%ebp)
80103ea2:	e8 07 c4 ff ff       	call   801002ae <brelse>
80103ea7:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103eaa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103eae:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103eb4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103eb7:	0f 8c 5a ff ff ff    	jl     80103e17 <write_log+0x1e>
  }
}
80103ebd:	90                   	nop
80103ebe:	90                   	nop
80103ebf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ec2:	c9                   	leave  
80103ec3:	c3                   	ret    

80103ec4 <commit>:

static void
commit()
{
80103ec4:	55                   	push   %ebp
80103ec5:	89 e5                	mov    %esp,%ebp
80103ec7:	53                   	push   %ebx
80103ec8:	83 ec 04             	sub    $0x4,%esp
80103ecb:	e8 b5 c4 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103ed0:	81 c3 f0 85 00 00    	add    $0x85f0,%ebx
  if (log.lh.n > 0) {
80103ed6:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103edc:	85 c0                	test   %eax,%eax
80103ede:	7e 1e                	jle    80103efe <commit+0x3a>
    write_log();     // Write modified blocks from cache to log
80103ee0:	e8 14 ff ff ff       	call   80103df9 <write_log>
    write_head();    // Write header to disk -- the real commit
80103ee5:	e8 b9 fc ff ff       	call   80103ba3 <write_head>
    install_trans(); // Now install writes to home locations
80103eea:	e8 62 fb ff ff       	call   80103a51 <install_trans>
    log.lh.n = 0;
80103eef:	c7 83 88 72 00 00 00 	movl   $0x0,0x7288(%ebx)
80103ef6:	00 00 00 
    write_head();    // Erase the transaction from the log
80103ef9:	e8 a5 fc ff ff       	call   80103ba3 <write_head>
  }
}
80103efe:	90                   	nop
80103eff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f02:	c9                   	leave  
80103f03:	c3                   	ret    

80103f04 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103f04:	55                   	push   %ebp
80103f05:	89 e5                	mov    %esp,%ebp
80103f07:	53                   	push   %ebx
80103f08:	83 ec 14             	sub    $0x14,%esp
80103f0b:	e8 75 c4 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80103f10:	81 c3 b0 85 00 00    	add    $0x85b0,%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103f16:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103f1c:	83 f8 1d             	cmp    $0x1d,%eax
80103f1f:	7f 13                	jg     80103f34 <log_write+0x30>
80103f21:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103f27:	8b 93 78 72 00 00    	mov    0x7278(%ebx),%edx
80103f2d:	83 ea 01             	sub    $0x1,%edx
80103f30:	39 d0                	cmp    %edx,%eax
80103f32:	7c 0f                	jl     80103f43 <log_write+0x3f>
    panic("too big a transaction");
80103f34:	83 ec 0c             	sub    $0xc,%esp
80103f37:	8d 83 f4 d1 ff ff    	lea    -0x2e0c(%ebx),%eax
80103f3d:	50                   	push   %eax
80103f3e:	e8 32 c7 ff ff       	call   80100675 <panic>
  if (log.outstanding < 1)
80103f43:	8b 83 7c 72 00 00    	mov    0x727c(%ebx),%eax
80103f49:	85 c0                	test   %eax,%eax
80103f4b:	7f 0f                	jg     80103f5c <log_write+0x58>
    panic("log_write outside of trans");
80103f4d:	83 ec 0c             	sub    $0xc,%esp
80103f50:	8d 83 0a d2 ff ff    	lea    -0x2df6(%ebx),%eax
80103f56:	50                   	push   %eax
80103f57:	e8 19 c7 ff ff       	call   80100675 <panic>

  acquire(&log.lock);
80103f5c:	83 ec 0c             	sub    $0xc,%esp
80103f5f:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103f65:	50                   	push   %eax
80103f66:	e8 97 1b 00 00       	call   80105b02 <acquire>
80103f6b:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80103f6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f75:	eb 1d                	jmp    80103f94 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103f77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f7a:	83 c0 10             	add    $0x10,%eax
80103f7d:	8b 84 83 4c 72 00 00 	mov    0x724c(%ebx,%eax,4),%eax
80103f84:	89 c2                	mov    %eax,%edx
80103f86:	8b 45 08             	mov    0x8(%ebp),%eax
80103f89:	8b 40 08             	mov    0x8(%eax),%eax
80103f8c:	39 c2                	cmp    %eax,%edx
80103f8e:	74 11                	je     80103fa1 <log_write+0x9d>
  for (i = 0; i < log.lh.n; i++) {
80103f90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103f94:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103f9a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103f9d:	7c d8                	jl     80103f77 <log_write+0x73>
80103f9f:	eb 01                	jmp    80103fa2 <log_write+0x9e>
      break;
80103fa1:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
80103fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa5:	8b 40 08             	mov    0x8(%eax),%eax
80103fa8:	89 c2                	mov    %eax,%edx
80103faa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fad:	83 c0 10             	add    $0x10,%eax
80103fb0:	89 94 83 4c 72 00 00 	mov    %edx,0x724c(%ebx,%eax,4)
  if (i == log.lh.n)
80103fb7:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103fbd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103fc0:	75 0f                	jne    80103fd1 <log_write+0xcd>
    log.lh.n++;
80103fc2:	8b 83 88 72 00 00    	mov    0x7288(%ebx),%eax
80103fc8:	83 c0 01             	add    $0x1,%eax
80103fcb:	89 83 88 72 00 00    	mov    %eax,0x7288(%ebx)
  b->flags |= B_DIRTY; // prevent eviction
80103fd1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd4:	8b 00                	mov    (%eax),%eax
80103fd6:	83 c8 04             	or     $0x4,%eax
80103fd9:	89 c2                	mov    %eax,%edx
80103fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80103fde:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103fe0:	83 ec 0c             	sub    $0xc,%esp
80103fe3:	8d 83 40 72 00 00    	lea    0x7240(%ebx),%eax
80103fe9:	50                   	push   %eax
80103fea:	e8 8e 1b 00 00       	call   80105b7d <release>
80103fef:	83 c4 10             	add    $0x10,%esp
}
80103ff2:	90                   	nop
80103ff3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ff6:	c9                   	leave  
80103ff7:	c3                   	ret    

80103ff8 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103ff8:	55                   	push   %ebp
80103ff9:	89 e5                	mov    %esp,%ebp
80103ffb:	83 ec 10             	sub    $0x10,%esp
80103ffe:	e8 25 cd ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104003:	05 bd 84 00 00       	add    $0x84bd,%eax
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104008:	8b 55 08             	mov    0x8(%ebp),%edx
8010400b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010400e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104011:	f0 87 02             	lock xchg %eax,(%edx)
80104014:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104017:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010401a:	c9                   	leave  
8010401b:	c3                   	ret    

8010401c <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010401c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80104020:	83 e4 f0             	and    $0xfffffff0,%esp
80104023:	ff 71 fc             	push   -0x4(%ecx)
80104026:	55                   	push   %ebp
80104027:	89 e5                	mov    %esp,%ebp
80104029:	53                   	push   %ebx
8010402a:	51                   	push   %ecx
8010402b:	e8 55 c3 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104030:	81 c3 90 84 00 00    	add    $0x8490,%ebx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80104036:	83 ec 08             	sub    $0x8,%esp
80104039:	68 00 00 40 80       	push   $0x80400000
8010403e:	c7 c0 00 75 11 80    	mov    $0x80117500,%eax
80104044:	50                   	push   %eax
80104045:	e8 d4 f0 ff ff       	call   8010311e <kinit1>
8010404a:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010404d:	e8 a8 4a 00 00       	call   80108afa <kvmalloc>
  mpinit();        // detect other processors
80104052:	e8 3b 04 00 00       	call   80104492 <mpinit>
  lapicinit();     // interrupt controller
80104057:	e8 f0 f4 ff ff       	call   8010354c <lapicinit>
  seginit();       // segment descriptors
8010405c:	e8 40 45 00 00       	call   801085a1 <seginit>
  picinit();       // disable pic
80104061:	e8 b9 05 00 00       	call   8010461f <picinit>
  ioapicinit();    // another interrupt controller
80104066:	e8 b1 ef ff ff       	call   8010301c <ioapicinit>
  consoleinit();   // console hardware
8010406b:	e8 50 cc ff ff       	call   80100cc0 <consoleinit>
  uartinit();      // serial port
80104070:	e8 69 38 00 00       	call   801078de <uartinit>
  pinit();         // process table
80104075:	e8 39 0a 00 00       	call   80104ab3 <pinit>
  tvinit();        // trap vectors
8010407a:	e8 ce 33 00 00       	call   8010744d <tvinit>
  binit();         // buffer cache
8010407f:	e8 b0 bf ff ff       	call   80100034 <binit>
  fileinit();      // file table
80104084:	e8 1b d2 ff ff       	call   801012a4 <fileinit>
  ideinit();       // disk 
80104089:	e8 e4 ea ff ff       	call   80102b72 <ideinit>
  startothers();   // start other processors
8010408e:	e8 97 00 00 00       	call   8010412a <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80104093:	83 ec 08             	sub    $0x8,%esp
80104096:	68 00 00 00 8e       	push   $0x8e000000
8010409b:	68 00 00 40 80       	push   $0x80400000
801040a0:	e8 c5 f0 ff ff       	call   8010316a <kinit2>
801040a5:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801040a8:	e8 53 0c 00 00       	call   80104d00 <userinit>
  mpmain();        // finish this processor's setup
801040ad:	e8 26 00 00 00       	call   801040d8 <mpmain>

801040b2 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801040b2:	55                   	push   %ebp
801040b3:	89 e5                	mov    %esp,%ebp
801040b5:	53                   	push   %ebx
801040b6:	83 ec 04             	sub    $0x4,%esp
801040b9:	e8 c7 c2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801040be:	81 c3 02 84 00 00    	add    $0x8402,%ebx
  switchkvm();
801040c4:	e8 59 4a 00 00       	call   80108b22 <switchkvm>
  seginit();
801040c9:	e8 d3 44 00 00       	call   801085a1 <seginit>
  lapicinit();
801040ce:	e8 79 f4 ff ff       	call   8010354c <lapicinit>
  mpmain();
801040d3:	e8 00 00 00 00       	call   801040d8 <mpmain>

801040d8 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801040d8:	55                   	push   %ebp
801040d9:	89 e5                	mov    %esp,%ebp
801040db:	56                   	push   %esi
801040dc:	53                   	push   %ebx
801040dd:	e8 a3 c2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801040e2:	81 c3 de 83 00 00    	add    $0x83de,%ebx
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801040e8:	e8 f8 09 00 00       	call   80104ae5 <cpuid>
801040ed:	89 c6                	mov    %eax,%esi
801040ef:	e8 f1 09 00 00       	call   80104ae5 <cpuid>
801040f4:	83 ec 04             	sub    $0x4,%esp
801040f7:	56                   	push   %esi
801040f8:	50                   	push   %eax
801040f9:	8d 83 25 d2 ff ff    	lea    -0x2ddb(%ebx),%eax
801040ff:	50                   	push   %eax
80104100:	e8 a3 c3 ff ff       	call   801004a8 <cprintf>
80104105:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80104108:	e8 e4 34 00 00       	call   801075f1 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
8010410d:	e8 00 0a 00 00       	call   80104b12 <mycpu>
80104112:	05 a0 00 00 00       	add    $0xa0,%eax
80104117:	83 ec 08             	sub    $0x8,%esp
8010411a:	6a 01                	push   $0x1
8010411c:	50                   	push   %eax
8010411d:	e8 d6 fe ff ff       	call   80103ff8 <xchg>
80104122:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80104125:	e8 cf 11 00 00       	call   801052f9 <scheduler>

8010412a <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
8010412a:	55                   	push   %ebp
8010412b:	89 e5                	mov    %esp,%ebp
8010412d:	53                   	push   %ebx
8010412e:	83 ec 14             	sub    $0x14,%esp
80104131:	e8 4f c2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104136:	81 c3 8a 83 00 00    	add    $0x838a,%ebx
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
8010413c:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80104143:	c7 c0 8a 00 00 00    	mov    $0x8a,%eax
80104149:	83 ec 04             	sub    $0x4,%esp
8010414c:	50                   	push   %eax
8010414d:	c7 c0 34 c4 10 80    	mov    $0x8010c434,%eax
80104153:	50                   	push   %eax
80104154:	ff 75 f0             	push   -0x10(%ebp)
80104157:	e8 6b 1d 00 00       	call   80105ec7 <memmove>
8010415c:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
8010415f:	c7 c0 e0 37 11 80    	mov    $0x801137e0,%eax
80104165:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104168:	eb 7c                	jmp    801041e6 <startothers+0xbc>
    if(c == mycpu())  // We've started already.
8010416a:	e8 a3 09 00 00       	call   80104b12 <mycpu>
8010416f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104172:	74 6a                	je     801041de <startothers+0xb4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80104174:	e8 20 f1 ff ff       	call   80103299 <kalloc>
80104179:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010417c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010417f:	83 e8 04             	sub    $0x4,%eax
80104182:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104185:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010418b:	89 10                	mov    %edx,(%eax)
    *(void(**)(void))(code-8) = mpenter;
8010418d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104190:	8d 50 f8             	lea    -0x8(%eax),%edx
80104193:	8d 83 f2 7b ff ff    	lea    -0x840e(%ebx),%eax
80104199:	89 02                	mov    %eax,(%edx)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010419b:	8d 83 40 eb ff ff    	lea    -0x14c0(%ebx),%eax
801041a1:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801041a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801041aa:	83 e8 0c             	sub    $0xc,%eax
801041ad:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
801041af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801041b2:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801041b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041bb:	0f b6 00             	movzbl (%eax),%eax
801041be:	0f b6 c0             	movzbl %al,%eax
801041c1:	83 ec 08             	sub    $0x8,%esp
801041c4:	52                   	push   %edx
801041c5:	50                   	push   %eax
801041c6:	e8 16 f5 ff ff       	call   801036e1 <lapicstartap>
801041cb:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801041ce:	90                   	nop
801041cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d2:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
801041d8:	85 c0                	test   %eax,%eax
801041da:	74 f3                	je     801041cf <startothers+0xa5>
801041dc:	eb 01                	jmp    801041df <startothers+0xb5>
      continue;
801041de:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
801041df:	81 45 f4 b0 00 00 00 	addl   $0xb0,-0xc(%ebp)
801041e6:	c7 c0 60 3d 11 80    	mov    $0x80113d60,%eax
801041ec:	8b 00                	mov    (%eax),%eax
801041ee:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
801041f4:	c7 c0 e0 37 11 80    	mov    $0x801137e0,%eax
801041fa:	01 d0                	add    %edx,%eax
801041fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801041ff:	0f 82 65 ff ff ff    	jb     8010416a <startothers+0x40>
      ;
  }
}
80104205:	90                   	nop
80104206:	90                   	nop
80104207:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010420a:	c9                   	leave  
8010420b:	c3                   	ret    

8010420c <inb>:
{
8010420c:	55                   	push   %ebp
8010420d:	89 e5                	mov    %esp,%ebp
8010420f:	83 ec 14             	sub    $0x14,%esp
80104212:	e8 11 cb ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104217:	05 a9 82 00 00       	add    $0x82a9,%eax
8010421c:	8b 45 08             	mov    0x8(%ebp),%eax
8010421f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104223:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80104227:	89 c2                	mov    %eax,%edx
80104229:	ec                   	in     (%dx),%al
8010422a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010422d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80104231:	c9                   	leave  
80104232:	c3                   	ret    

80104233 <outb>:
{
80104233:	55                   	push   %ebp
80104234:	89 e5                	mov    %esp,%ebp
80104236:	83 ec 08             	sub    $0x8,%esp
80104239:	e8 ea ca ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010423e:	05 82 82 00 00       	add    $0x8282,%eax
80104243:	8b 45 08             	mov    0x8(%ebp),%eax
80104246:	8b 55 0c             	mov    0xc(%ebp),%edx
80104249:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010424d:	89 d0                	mov    %edx,%eax
8010424f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104252:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80104256:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010425a:	ee                   	out    %al,(%dx)
}
8010425b:	90                   	nop
8010425c:	c9                   	leave  
8010425d:	c3                   	ret    

8010425e <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
8010425e:	55                   	push   %ebp
8010425f:	89 e5                	mov    %esp,%ebp
80104261:	83 ec 10             	sub    $0x10,%esp
80104264:	e8 bf ca ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104269:	05 57 82 00 00       	add    $0x8257,%eax
  int i, sum;

  sum = 0;
8010426e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80104275:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010427c:	eb 15                	jmp    80104293 <sum+0x35>
    sum += addr[i];
8010427e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104281:	8b 45 08             	mov    0x8(%ebp),%eax
80104284:	01 d0                	add    %edx,%eax
80104286:	0f b6 00             	movzbl (%eax),%eax
80104289:	0f b6 c0             	movzbl %al,%eax
8010428c:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
8010428f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104293:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104296:	3b 45 0c             	cmp    0xc(%ebp),%eax
80104299:	7c e3                	jl     8010427e <sum+0x20>
  return sum;
8010429b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
8010429e:	c9                   	leave  
8010429f:	c3                   	ret    

801042a0 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 14             	sub    $0x14,%esp
801042a7:	e8 d9 c0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801042ac:	81 c3 14 82 00 00    	add    $0x8214,%ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
801042b2:	8b 45 08             	mov    0x8(%ebp),%eax
801042b5:	05 00 00 00 80       	add    $0x80000000,%eax
801042ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
801042bd:	8b 55 0c             	mov    0xc(%ebp),%edx
801042c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801042c3:	01 d0                	add    %edx,%eax
801042c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801042c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801042cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042ce:	eb 38                	jmp    80104308 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801042d0:	83 ec 04             	sub    $0x4,%esp
801042d3:	6a 04                	push   $0x4
801042d5:	8d 83 3c d2 ff ff    	lea    -0x2dc4(%ebx),%eax
801042db:	50                   	push   %eax
801042dc:	ff 75 f4             	push   -0xc(%ebp)
801042df:	e8 81 1b 00 00       	call   80105e65 <memcmp>
801042e4:	83 c4 10             	add    $0x10,%esp
801042e7:	85 c0                	test   %eax,%eax
801042e9:	75 19                	jne    80104304 <mpsearch1+0x64>
801042eb:	83 ec 08             	sub    $0x8,%esp
801042ee:	6a 10                	push   $0x10
801042f0:	ff 75 f4             	push   -0xc(%ebp)
801042f3:	e8 66 ff ff ff       	call   8010425e <sum>
801042f8:	83 c4 10             	add    $0x10,%esp
801042fb:	84 c0                	test   %al,%al
801042fd:	75 05                	jne    80104304 <mpsearch1+0x64>
      return (struct mp*)p;
801042ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104302:	eb 11                	jmp    80104315 <mpsearch1+0x75>
  for(p = addr; p < e; p += sizeof(struct mp))
80104304:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80104308:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010430b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010430e:	72 c0                	jb     801042d0 <mpsearch1+0x30>
  return 0;
80104310:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104318:	c9                   	leave  
80104319:	c3                   	ret    

8010431a <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
8010431a:	55                   	push   %ebp
8010431b:	89 e5                	mov    %esp,%ebp
8010431d:	83 ec 18             	sub    $0x18,%esp
80104320:	e8 03 ca ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104325:	05 9b 81 00 00       	add    $0x819b,%eax
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
8010432a:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80104331:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104334:	83 c0 0f             	add    $0xf,%eax
80104337:	0f b6 00             	movzbl (%eax),%eax
8010433a:	0f b6 c0             	movzbl %al,%eax
8010433d:	c1 e0 08             	shl    $0x8,%eax
80104340:	89 c2                	mov    %eax,%edx
80104342:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104345:	83 c0 0e             	add    $0xe,%eax
80104348:	0f b6 00             	movzbl (%eax),%eax
8010434b:	0f b6 c0             	movzbl %al,%eax
8010434e:	09 d0                	or     %edx,%eax
80104350:	c1 e0 04             	shl    $0x4,%eax
80104353:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104356:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010435a:	74 21                	je     8010437d <mpsearch+0x63>
    if((mp = mpsearch1(p, 1024)))
8010435c:	83 ec 08             	sub    $0x8,%esp
8010435f:	68 00 04 00 00       	push   $0x400
80104364:	ff 75 f0             	push   -0x10(%ebp)
80104367:	e8 34 ff ff ff       	call   801042a0 <mpsearch1>
8010436c:	83 c4 10             	add    $0x10,%esp
8010436f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104372:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80104376:	74 51                	je     801043c9 <mpsearch+0xaf>
      return mp;
80104378:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010437b:	eb 61                	jmp    801043de <mpsearch+0xc4>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
8010437d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104380:	83 c0 14             	add    $0x14,%eax
80104383:	0f b6 00             	movzbl (%eax),%eax
80104386:	0f b6 c0             	movzbl %al,%eax
80104389:	c1 e0 08             	shl    $0x8,%eax
8010438c:	89 c2                	mov    %eax,%edx
8010438e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104391:	83 c0 13             	add    $0x13,%eax
80104394:	0f b6 00             	movzbl (%eax),%eax
80104397:	0f b6 c0             	movzbl %al,%eax
8010439a:	09 d0                	or     %edx,%eax
8010439c:	c1 e0 0a             	shl    $0xa,%eax
8010439f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
801043a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801043a5:	2d 00 04 00 00       	sub    $0x400,%eax
801043aa:	83 ec 08             	sub    $0x8,%esp
801043ad:	68 00 04 00 00       	push   $0x400
801043b2:	50                   	push   %eax
801043b3:	e8 e8 fe ff ff       	call   801042a0 <mpsearch1>
801043b8:	83 c4 10             	add    $0x10,%esp
801043bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
801043be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801043c2:	74 05                	je     801043c9 <mpsearch+0xaf>
      return mp;
801043c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801043c7:	eb 15                	jmp    801043de <mpsearch+0xc4>
  }
  return mpsearch1(0xF0000, 0x10000);
801043c9:	83 ec 08             	sub    $0x8,%esp
801043cc:	68 00 00 01 00       	push   $0x10000
801043d1:	68 00 00 0f 00       	push   $0xf0000
801043d6:	e8 c5 fe ff ff       	call   801042a0 <mpsearch1>
801043db:	83 c4 10             	add    $0x10,%esp
}
801043de:	c9                   	leave  
801043df:	c3                   	ret    

801043e0 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 14             	sub    $0x14,%esp
801043e7:	e8 99 bf ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801043ec:	81 c3 d4 80 00 00    	add    $0x80d4,%ebx
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801043f2:	e8 23 ff ff ff       	call   8010431a <mpsearch>
801043f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801043fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801043fe:	74 0a                	je     8010440a <mpconfig+0x2a>
80104400:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104403:	8b 40 04             	mov    0x4(%eax),%eax
80104406:	85 c0                	test   %eax,%eax
80104408:	75 07                	jne    80104411 <mpconfig+0x31>
    return 0;
8010440a:	b8 00 00 00 00       	mov    $0x0,%eax
8010440f:	eb 7c                	jmp    8010448d <mpconfig+0xad>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80104411:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104414:	8b 40 04             	mov    0x4(%eax),%eax
80104417:	05 00 00 00 80       	add    $0x80000000,%eax
8010441c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010441f:	83 ec 04             	sub    $0x4,%esp
80104422:	6a 04                	push   $0x4
80104424:	8d 83 41 d2 ff ff    	lea    -0x2dbf(%ebx),%eax
8010442a:	50                   	push   %eax
8010442b:	ff 75 f0             	push   -0x10(%ebp)
8010442e:	e8 32 1a 00 00       	call   80105e65 <memcmp>
80104433:	83 c4 10             	add    $0x10,%esp
80104436:	85 c0                	test   %eax,%eax
80104438:	74 07                	je     80104441 <mpconfig+0x61>
    return 0;
8010443a:	b8 00 00 00 00       	mov    $0x0,%eax
8010443f:	eb 4c                	jmp    8010448d <mpconfig+0xad>
  if(conf->version != 1 && conf->version != 4)
80104441:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104444:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80104448:	3c 01                	cmp    $0x1,%al
8010444a:	74 12                	je     8010445e <mpconfig+0x7e>
8010444c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010444f:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80104453:	3c 04                	cmp    $0x4,%al
80104455:	74 07                	je     8010445e <mpconfig+0x7e>
    return 0;
80104457:	b8 00 00 00 00       	mov    $0x0,%eax
8010445c:	eb 2f                	jmp    8010448d <mpconfig+0xad>
  if(sum((uchar*)conf, conf->length) != 0)
8010445e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104461:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80104465:	0f b7 c0             	movzwl %ax,%eax
80104468:	83 ec 08             	sub    $0x8,%esp
8010446b:	50                   	push   %eax
8010446c:	ff 75 f0             	push   -0x10(%ebp)
8010446f:	e8 ea fd ff ff       	call   8010425e <sum>
80104474:	83 c4 10             	add    $0x10,%esp
80104477:	84 c0                	test   %al,%al
80104479:	74 07                	je     80104482 <mpconfig+0xa2>
    return 0;
8010447b:	b8 00 00 00 00       	mov    $0x0,%eax
80104480:	eb 0b                	jmp    8010448d <mpconfig+0xad>
  *pmp = mp;
80104482:	8b 45 08             	mov    0x8(%ebp),%eax
80104485:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104488:	89 10                	mov    %edx,(%eax)
  return conf;
8010448a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
8010448d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104490:	c9                   	leave  
80104491:	c3                   	ret    

80104492 <mpinit>:

void
mpinit(void)
{
80104492:	55                   	push   %ebp
80104493:	89 e5                	mov    %esp,%ebp
80104495:	53                   	push   %ebx
80104496:	83 ec 24             	sub    $0x24,%esp
80104499:	e8 e7 be ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010449e:	81 c3 22 80 00 00    	add    $0x8022,%ebx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	8d 45 dc             	lea    -0x24(%ebp),%eax
801044aa:	50                   	push   %eax
801044ab:	e8 30 ff ff ff       	call   801043e0 <mpconfig>
801044b0:	83 c4 10             	add    $0x10,%esp
801044b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
801044b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801044ba:	75 0f                	jne    801044cb <mpinit+0x39>
    panic("Expect to run on an SMP");
801044bc:	83 ec 0c             	sub    $0xc,%esp
801044bf:	8d 83 46 d2 ff ff    	lea    -0x2dba(%ebx),%eax
801044c5:	50                   	push   %eax
801044c6:	e8 aa c1 ff ff       	call   80100675 <panic>
  ismp = 1;
801044cb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
801044d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801044d5:	8b 50 24             	mov    0x24(%eax),%edx
801044d8:	c7 c0 e0 36 11 80    	mov    $0x801136e0,%eax
801044de:	89 10                	mov    %edx,(%eax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801044e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801044e3:	83 c0 2c             	add    $0x2c,%eax
801044e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801044e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801044ec:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801044f0:	0f b7 d0             	movzwl %ax,%edx
801044f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801044f6:	01 d0                	add    %edx,%eax
801044f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
801044fb:	e9 92 00 00 00       	jmp    80104592 <mpinit+0x100>
    switch(*p){
80104500:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104503:	0f b6 00             	movzbl (%eax),%eax
80104506:	0f b6 c0             	movzbl %al,%eax
80104509:	83 f8 04             	cmp    $0x4,%eax
8010450c:	7f 7c                	jg     8010458a <mpinit+0xf8>
8010450e:	83 f8 03             	cmp    $0x3,%eax
80104511:	7d 71                	jge    80104584 <mpinit+0xf2>
80104513:	83 f8 02             	cmp    $0x2,%eax
80104516:	74 53                	je     8010456b <mpinit+0xd9>
80104518:	83 f8 02             	cmp    $0x2,%eax
8010451b:	7f 6d                	jg     8010458a <mpinit+0xf8>
8010451d:	85 c0                	test   %eax,%eax
8010451f:	74 07                	je     80104528 <mpinit+0x96>
80104521:	83 f8 01             	cmp    $0x1,%eax
80104524:	74 5e                	je     80104584 <mpinit+0xf2>
80104526:	eb 62                	jmp    8010458a <mpinit+0xf8>
    case MPPROC:
      proc = (struct mpproc*)p;
80104528:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452b:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(ncpu < NCPU) {
8010452e:	8b 83 a0 78 00 00    	mov    0x78a0(%ebx),%eax
80104534:	83 f8 07             	cmp    $0x7,%eax
80104537:	7f 2c                	jg     80104565 <mpinit+0xd3>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80104539:	8b 93 a0 78 00 00    	mov    0x78a0(%ebx),%edx
8010453f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104542:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104546:	8d 8b 20 73 00 00    	lea    0x7320(%ebx),%ecx
8010454c:	69 d2 b0 00 00 00    	imul   $0xb0,%edx,%edx
80104552:	01 ca                	add    %ecx,%edx
80104554:	88 02                	mov    %al,(%edx)
        ncpu++;
80104556:	8b 83 a0 78 00 00    	mov    0x78a0(%ebx),%eax
8010455c:	83 c0 01             	add    $0x1,%eax
8010455f:	89 83 a0 78 00 00    	mov    %eax,0x78a0(%ebx)
      }
      p += sizeof(struct mpproc);
80104565:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80104569:	eb 27                	jmp    80104592 <mpinit+0x100>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
8010456b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010456e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80104571:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104574:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104578:	88 83 a4 78 00 00    	mov    %al,0x78a4(%ebx)
      p += sizeof(struct mpioapic);
8010457e:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104582:	eb 0e                	jmp    80104592 <mpinit+0x100>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80104584:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104588:	eb 08                	jmp    80104592 <mpinit+0x100>
    default:
      ismp = 0;
8010458a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      break;
80104591:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104592:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104595:	3b 45 e8             	cmp    -0x18(%ebp),%eax
80104598:	0f 82 62 ff ff ff    	jb     80104500 <mpinit+0x6e>
    }
  }
  if(!ismp)
8010459e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801045a2:	75 0f                	jne    801045b3 <mpinit+0x121>
    panic("Didn't find a suitable machine");
801045a4:	83 ec 0c             	sub    $0xc,%esp
801045a7:	8d 83 60 d2 ff ff    	lea    -0x2da0(%ebx),%eax
801045ad:	50                   	push   %eax
801045ae:	e8 c2 c0 ff ff       	call   80100675 <panic>

  if(mp->imcrp){
801045b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045b6:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
801045ba:	84 c0                	test   %al,%al
801045bc:	74 30                	je     801045ee <mpinit+0x15c>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
801045be:	83 ec 08             	sub    $0x8,%esp
801045c1:	6a 70                	push   $0x70
801045c3:	6a 22                	push   $0x22
801045c5:	e8 69 fc ff ff       	call   80104233 <outb>
801045ca:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801045cd:	83 ec 0c             	sub    $0xc,%esp
801045d0:	6a 23                	push   $0x23
801045d2:	e8 35 fc ff ff       	call   8010420c <inb>
801045d7:	83 c4 10             	add    $0x10,%esp
801045da:	83 c8 01             	or     $0x1,%eax
801045dd:	0f b6 c0             	movzbl %al,%eax
801045e0:	83 ec 08             	sub    $0x8,%esp
801045e3:	50                   	push   %eax
801045e4:	6a 23                	push   $0x23
801045e6:	e8 48 fc ff ff       	call   80104233 <outb>
801045eb:	83 c4 10             	add    $0x10,%esp
  }
}
801045ee:	90                   	nop
801045ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045f2:	c9                   	leave  
801045f3:	c3                   	ret    

801045f4 <outb>:
{
801045f4:	55                   	push   %ebp
801045f5:	89 e5                	mov    %esp,%ebp
801045f7:	83 ec 08             	sub    $0x8,%esp
801045fa:	e8 29 c7 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801045ff:	05 c1 7e 00 00       	add    $0x7ec1,%eax
80104604:	8b 45 08             	mov    0x8(%ebp),%eax
80104607:	8b 55 0c             	mov    0xc(%ebp),%edx
8010460a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010460e:	89 d0                	mov    %edx,%eax
80104610:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104613:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80104617:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010461b:	ee                   	out    %al,(%dx)
}
8010461c:	90                   	nop
8010461d:	c9                   	leave  
8010461e:	c3                   	ret    

8010461f <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
8010461f:	55                   	push   %ebp
80104620:	89 e5                	mov    %esp,%ebp
80104622:	e8 01 c7 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104627:	05 99 7e 00 00       	add    $0x7e99,%eax
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
8010462c:	68 ff 00 00 00       	push   $0xff
80104631:	6a 21                	push   $0x21
80104633:	e8 bc ff ff ff       	call   801045f4 <outb>
80104638:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
8010463b:	68 ff 00 00 00       	push   $0xff
80104640:	68 a1 00 00 00       	push   $0xa1
80104645:	e8 aa ff ff ff       	call   801045f4 <outb>
8010464a:	83 c4 08             	add    $0x8,%esp
}
8010464d:	90                   	nop
8010464e:	c9                   	leave  
8010464f:	c3                   	ret    

80104650 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	53                   	push   %ebx
80104654:	83 ec 14             	sub    $0x14,%esp
80104657:	e8 29 bd ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010465c:	81 c3 64 7e 00 00    	add    $0x7e64,%ebx
  struct pipe *p;

  p = 0;
80104662:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80104669:	8b 45 0c             	mov    0xc(%ebp),%eax
8010466c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104672:	8b 45 0c             	mov    0xc(%ebp),%eax
80104675:	8b 10                	mov    (%eax),%edx
80104677:	8b 45 08             	mov    0x8(%ebp),%eax
8010467a:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010467c:	e8 55 cc ff ff       	call   801012d6 <filealloc>
80104681:	8b 55 08             	mov    0x8(%ebp),%edx
80104684:	89 02                	mov    %eax,(%edx)
80104686:	8b 45 08             	mov    0x8(%ebp),%eax
80104689:	8b 00                	mov    (%eax),%eax
8010468b:	85 c0                	test   %eax,%eax
8010468d:	0f 84 ca 00 00 00    	je     8010475d <pipealloc+0x10d>
80104693:	e8 3e cc ff ff       	call   801012d6 <filealloc>
80104698:	8b 55 0c             	mov    0xc(%ebp),%edx
8010469b:	89 02                	mov    %eax,(%edx)
8010469d:	8b 45 0c             	mov    0xc(%ebp),%eax
801046a0:	8b 00                	mov    (%eax),%eax
801046a2:	85 c0                	test   %eax,%eax
801046a4:	0f 84 b3 00 00 00    	je     8010475d <pipealloc+0x10d>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801046aa:	e8 ea eb ff ff       	call   80103299 <kalloc>
801046af:	89 45 f4             	mov    %eax,-0xc(%ebp)
801046b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046b6:	0f 84 a4 00 00 00    	je     80104760 <pipealloc+0x110>
    goto bad;
  p->readopen = 1;
801046bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046bf:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801046c6:	00 00 00 
  p->writeopen = 1;
801046c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046cc:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801046d3:	00 00 00 
  p->nwrite = 0;
801046d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046d9:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801046e0:	00 00 00 
  p->nread = 0;
801046e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046e6:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801046ed:	00 00 00 
  initlock(&p->lock, "pipe");
801046f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046f3:	83 ec 08             	sub    $0x8,%esp
801046f6:	8d 93 7f d2 ff ff    	lea    -0x2d81(%ebx),%edx
801046fc:	52                   	push   %edx
801046fd:	50                   	push   %eax
801046fe:	e8 d3 13 00 00       	call   80105ad6 <initlock>
80104703:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104706:	8b 45 08             	mov    0x8(%ebp),%eax
80104709:	8b 00                	mov    (%eax),%eax
8010470b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104711:	8b 45 08             	mov    0x8(%ebp),%eax
80104714:	8b 00                	mov    (%eax),%eax
80104716:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010471a:	8b 45 08             	mov    0x8(%ebp),%eax
8010471d:	8b 00                	mov    (%eax),%eax
8010471f:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104723:	8b 45 08             	mov    0x8(%ebp),%eax
80104726:	8b 00                	mov    (%eax),%eax
80104728:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010472b:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010472e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104731:	8b 00                	mov    (%eax),%eax
80104733:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104739:	8b 45 0c             	mov    0xc(%ebp),%eax
8010473c:	8b 00                	mov    (%eax),%eax
8010473e:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104742:	8b 45 0c             	mov    0xc(%ebp),%eax
80104745:	8b 00                	mov    (%eax),%eax
80104747:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010474b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010474e:	8b 00                	mov    (%eax),%eax
80104750:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104753:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104756:	b8 00 00 00 00       	mov    $0x0,%eax
8010475b:	eb 51                	jmp    801047ae <pipealloc+0x15e>
    goto bad;
8010475d:	90                   	nop
8010475e:	eb 01                	jmp    80104761 <pipealloc+0x111>
    goto bad;
80104760:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
80104761:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104765:	74 0e                	je     80104775 <pipealloc+0x125>
    kfree((char*)p);
80104767:	83 ec 0c             	sub    $0xc,%esp
8010476a:	ff 75 f4             	push   -0xc(%ebp)
8010476d:	e8 73 ea ff ff       	call   801031e5 <kfree>
80104772:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104775:	8b 45 08             	mov    0x8(%ebp),%eax
80104778:	8b 00                	mov    (%eax),%eax
8010477a:	85 c0                	test   %eax,%eax
8010477c:	74 11                	je     8010478f <pipealloc+0x13f>
    fileclose(*f0);
8010477e:	8b 45 08             	mov    0x8(%ebp),%eax
80104781:	8b 00                	mov    (%eax),%eax
80104783:	83 ec 0c             	sub    $0xc,%esp
80104786:	50                   	push   %eax
80104787:	e8 35 cc ff ff       	call   801013c1 <fileclose>
8010478c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010478f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104792:	8b 00                	mov    (%eax),%eax
80104794:	85 c0                	test   %eax,%eax
80104796:	74 11                	je     801047a9 <pipealloc+0x159>
    fileclose(*f1);
80104798:	8b 45 0c             	mov    0xc(%ebp),%eax
8010479b:	8b 00                	mov    (%eax),%eax
8010479d:	83 ec 0c             	sub    $0xc,%esp
801047a0:	50                   	push   %eax
801047a1:	e8 1b cc ff ff       	call   801013c1 <fileclose>
801047a6:	83 c4 10             	add    $0x10,%esp
  return -1;
801047a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047b1:	c9                   	leave  
801047b2:	c3                   	ret    

801047b3 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801047b3:	55                   	push   %ebp
801047b4:	89 e5                	mov    %esp,%ebp
801047b6:	53                   	push   %ebx
801047b7:	83 ec 04             	sub    $0x4,%esp
801047ba:	e8 c6 bb ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801047bf:	81 c3 01 7d 00 00    	add    $0x7d01,%ebx
  acquire(&p->lock);
801047c5:	8b 45 08             	mov    0x8(%ebp),%eax
801047c8:	83 ec 0c             	sub    $0xc,%esp
801047cb:	50                   	push   %eax
801047cc:	e8 31 13 00 00       	call   80105b02 <acquire>
801047d1:	83 c4 10             	add    $0x10,%esp
  if(writable){
801047d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801047d8:	74 23                	je     801047fd <pipeclose+0x4a>
    p->writeopen = 0;
801047da:	8b 45 08             	mov    0x8(%ebp),%eax
801047dd:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801047e4:	00 00 00 
    wakeup(&p->nread);
801047e7:	8b 45 08             	mov    0x8(%ebp),%eax
801047ea:	05 34 02 00 00       	add    $0x234,%eax
801047ef:	83 ec 0c             	sub    $0xc,%esp
801047f2:	50                   	push   %eax
801047f3:	e8 54 0e 00 00       	call   8010564c <wakeup>
801047f8:	83 c4 10             	add    $0x10,%esp
801047fb:	eb 21                	jmp    8010481e <pipeclose+0x6b>
  } else {
    p->readopen = 0;
801047fd:	8b 45 08             	mov    0x8(%ebp),%eax
80104800:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104807:	00 00 00 
    wakeup(&p->nwrite);
8010480a:	8b 45 08             	mov    0x8(%ebp),%eax
8010480d:	05 38 02 00 00       	add    $0x238,%eax
80104812:	83 ec 0c             	sub    $0xc,%esp
80104815:	50                   	push   %eax
80104816:	e8 31 0e 00 00       	call   8010564c <wakeup>
8010481b:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010481e:	8b 45 08             	mov    0x8(%ebp),%eax
80104821:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104827:	85 c0                	test   %eax,%eax
80104829:	75 2c                	jne    80104857 <pipeclose+0xa4>
8010482b:	8b 45 08             	mov    0x8(%ebp),%eax
8010482e:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104834:	85 c0                	test   %eax,%eax
80104836:	75 1f                	jne    80104857 <pipeclose+0xa4>
    release(&p->lock);
80104838:	8b 45 08             	mov    0x8(%ebp),%eax
8010483b:	83 ec 0c             	sub    $0xc,%esp
8010483e:	50                   	push   %eax
8010483f:	e8 39 13 00 00       	call   80105b7d <release>
80104844:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104847:	83 ec 0c             	sub    $0xc,%esp
8010484a:	ff 75 08             	push   0x8(%ebp)
8010484d:	e8 93 e9 ff ff       	call   801031e5 <kfree>
80104852:	83 c4 10             	add    $0x10,%esp
80104855:	eb 10                	jmp    80104867 <pipeclose+0xb4>
  } else
    release(&p->lock);
80104857:	8b 45 08             	mov    0x8(%ebp),%eax
8010485a:	83 ec 0c             	sub    $0xc,%esp
8010485d:	50                   	push   %eax
8010485e:	e8 1a 13 00 00       	call   80105b7d <release>
80104863:	83 c4 10             	add    $0x10,%esp
}
80104866:	90                   	nop
80104867:	90                   	nop
80104868:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010486b:	c9                   	leave  
8010486c:	c3                   	ret    

8010486d <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
8010486d:	55                   	push   %ebp
8010486e:	89 e5                	mov    %esp,%ebp
80104870:	56                   	push   %esi
80104871:	53                   	push   %ebx
80104872:	83 ec 10             	sub    $0x10,%esp
80104875:	e8 0b bb ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010487a:	81 c3 46 7c 00 00    	add    $0x7c46,%ebx
  int i;

  acquire(&p->lock);
80104880:	8b 45 08             	mov    0x8(%ebp),%eax
80104883:	83 ec 0c             	sub    $0xc,%esp
80104886:	50                   	push   %eax
80104887:	e8 76 12 00 00       	call   80105b02 <acquire>
8010488c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
8010488f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104896:	e9 ad 00 00 00       	jmp    80104948 <pipewrite+0xdb>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
8010489b:	8b 45 08             	mov    0x8(%ebp),%eax
8010489e:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801048a4:	85 c0                	test   %eax,%eax
801048a6:	74 0c                	je     801048b4 <pipewrite+0x47>
801048a8:	e8 f9 02 00 00       	call   80104ba6 <myproc>
801048ad:	8b 40 24             	mov    0x24(%eax),%eax
801048b0:	85 c0                	test   %eax,%eax
801048b2:	74 19                	je     801048cd <pipewrite+0x60>
        release(&p->lock);
801048b4:	8b 45 08             	mov    0x8(%ebp),%eax
801048b7:	83 ec 0c             	sub    $0xc,%esp
801048ba:	50                   	push   %eax
801048bb:	e8 bd 12 00 00       	call   80105b7d <release>
801048c0:	83 c4 10             	add    $0x10,%esp
        return -1;
801048c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048c8:	e9 a9 00 00 00       	jmp    80104976 <pipewrite+0x109>
      }
      wakeup(&p->nread);
801048cd:	8b 45 08             	mov    0x8(%ebp),%eax
801048d0:	05 34 02 00 00       	add    $0x234,%eax
801048d5:	83 ec 0c             	sub    $0xc,%esp
801048d8:	50                   	push   %eax
801048d9:	e8 6e 0d 00 00       	call   8010564c <wakeup>
801048de:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801048e1:	8b 45 08             	mov    0x8(%ebp),%eax
801048e4:	8b 55 08             	mov    0x8(%ebp),%edx
801048e7:	81 c2 38 02 00 00    	add    $0x238,%edx
801048ed:	83 ec 08             	sub    $0x8,%esp
801048f0:	50                   	push   %eax
801048f1:	52                   	push   %edx
801048f2:	e8 45 0c 00 00       	call   8010553c <sleep>
801048f7:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801048fa:	8b 45 08             	mov    0x8(%ebp),%eax
801048fd:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104903:	8b 45 08             	mov    0x8(%ebp),%eax
80104906:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010490c:	05 00 02 00 00       	add    $0x200,%eax
80104911:	39 c2                	cmp    %eax,%edx
80104913:	74 86                	je     8010489b <pipewrite+0x2e>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104915:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104918:	8b 45 0c             	mov    0xc(%ebp),%eax
8010491b:	8d 34 02             	lea    (%edx,%eax,1),%esi
8010491e:	8b 45 08             	mov    0x8(%ebp),%eax
80104921:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104927:	8d 48 01             	lea    0x1(%eax),%ecx
8010492a:	8b 55 08             	mov    0x8(%ebp),%edx
8010492d:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104933:	25 ff 01 00 00       	and    $0x1ff,%eax
80104938:	89 c1                	mov    %eax,%ecx
8010493a:	0f b6 16             	movzbl (%esi),%edx
8010493d:	8b 45 08             	mov    0x8(%ebp),%eax
80104940:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
80104944:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104948:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010494b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010494e:	7c aa                	jl     801048fa <pipewrite+0x8d>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104950:	8b 45 08             	mov    0x8(%ebp),%eax
80104953:	05 34 02 00 00       	add    $0x234,%eax
80104958:	83 ec 0c             	sub    $0xc,%esp
8010495b:	50                   	push   %eax
8010495c:	e8 eb 0c 00 00       	call   8010564c <wakeup>
80104961:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104964:	8b 45 08             	mov    0x8(%ebp),%eax
80104967:	83 ec 0c             	sub    $0xc,%esp
8010496a:	50                   	push   %eax
8010496b:	e8 0d 12 00 00       	call   80105b7d <release>
80104970:	83 c4 10             	add    $0x10,%esp
  return n;
80104973:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104976:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104979:	5b                   	pop    %ebx
8010497a:	5e                   	pop    %esi
8010497b:	5d                   	pop    %ebp
8010497c:	c3                   	ret    

8010497d <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010497d:	55                   	push   %ebp
8010497e:	89 e5                	mov    %esp,%ebp
80104980:	53                   	push   %ebx
80104981:	83 ec 14             	sub    $0x14,%esp
80104984:	e8 fc b9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104989:	81 c3 37 7b 00 00    	add    $0x7b37,%ebx
  int i;

  acquire(&p->lock);
8010498f:	8b 45 08             	mov    0x8(%ebp),%eax
80104992:	83 ec 0c             	sub    $0xc,%esp
80104995:	50                   	push   %eax
80104996:	e8 67 11 00 00       	call   80105b02 <acquire>
8010499b:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010499e:	eb 3e                	jmp    801049de <piperead+0x61>
    if(myproc()->killed){
801049a0:	e8 01 02 00 00       	call   80104ba6 <myproc>
801049a5:	8b 40 24             	mov    0x24(%eax),%eax
801049a8:	85 c0                	test   %eax,%eax
801049aa:	74 19                	je     801049c5 <piperead+0x48>
      release(&p->lock);
801049ac:	8b 45 08             	mov    0x8(%ebp),%eax
801049af:	83 ec 0c             	sub    $0xc,%esp
801049b2:	50                   	push   %eax
801049b3:	e8 c5 11 00 00       	call   80105b7d <release>
801049b8:	83 c4 10             	add    $0x10,%esp
      return -1;
801049bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049c0:	e9 be 00 00 00       	jmp    80104a83 <piperead+0x106>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801049c5:	8b 45 08             	mov    0x8(%ebp),%eax
801049c8:	8b 55 08             	mov    0x8(%ebp),%edx
801049cb:	81 c2 34 02 00 00    	add    $0x234,%edx
801049d1:	83 ec 08             	sub    $0x8,%esp
801049d4:	50                   	push   %eax
801049d5:	52                   	push   %edx
801049d6:	e8 61 0b 00 00       	call   8010553c <sleep>
801049db:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801049de:	8b 45 08             	mov    0x8(%ebp),%eax
801049e1:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801049e7:	8b 45 08             	mov    0x8(%ebp),%eax
801049ea:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801049f0:	39 c2                	cmp    %eax,%edx
801049f2:	75 0d                	jne    80104a01 <piperead+0x84>
801049f4:	8b 45 08             	mov    0x8(%ebp),%eax
801049f7:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801049fd:	85 c0                	test   %eax,%eax
801049ff:	75 9f                	jne    801049a0 <piperead+0x23>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104a01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104a08:	eb 48                	jmp    80104a52 <piperead+0xd5>
    if(p->nread == p->nwrite)
80104a0a:	8b 45 08             	mov    0x8(%ebp),%eax
80104a0d:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104a13:	8b 45 08             	mov    0x8(%ebp),%eax
80104a16:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104a1c:	39 c2                	cmp    %eax,%edx
80104a1e:	74 3c                	je     80104a5c <piperead+0xdf>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104a20:	8b 45 08             	mov    0x8(%ebp),%eax
80104a23:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104a29:	8d 48 01             	lea    0x1(%eax),%ecx
80104a2c:	8b 55 08             	mov    0x8(%ebp),%edx
80104a2f:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104a35:	25 ff 01 00 00       	and    $0x1ff,%eax
80104a3a:	89 c1                	mov    %eax,%ecx
80104a3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a42:	01 c2                	add    %eax,%edx
80104a44:	8b 45 08             	mov    0x8(%ebp),%eax
80104a47:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
80104a4c:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104a4e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a55:	3b 45 10             	cmp    0x10(%ebp),%eax
80104a58:	7c b0                	jl     80104a0a <piperead+0x8d>
80104a5a:	eb 01                	jmp    80104a5d <piperead+0xe0>
      break;
80104a5c:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104a5d:	8b 45 08             	mov    0x8(%ebp),%eax
80104a60:	05 38 02 00 00       	add    $0x238,%eax
80104a65:	83 ec 0c             	sub    $0xc,%esp
80104a68:	50                   	push   %eax
80104a69:	e8 de 0b 00 00       	call   8010564c <wakeup>
80104a6e:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104a71:	8b 45 08             	mov    0x8(%ebp),%eax
80104a74:	83 ec 0c             	sub    $0xc,%esp
80104a77:	50                   	push   %eax
80104a78:	e8 00 11 00 00       	call   80105b7d <release>
80104a7d:	83 c4 10             	add    $0x10,%esp
  return i;
80104a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104a83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a86:	c9                   	leave  
80104a87:	c3                   	ret    

80104a88 <readeflags>:
{
80104a88:	55                   	push   %ebp
80104a89:	89 e5                	mov    %esp,%ebp
80104a8b:	83 ec 10             	sub    $0x10,%esp
80104a8e:	e8 95 c2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104a93:	05 2d 7a 00 00       	add    $0x7a2d,%eax
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104a98:	9c                   	pushf  
80104a99:	58                   	pop    %eax
80104a9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104a9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104aa0:	c9                   	leave  
80104aa1:	c3                   	ret    

80104aa2 <sti>:
{
80104aa2:	55                   	push   %ebp
80104aa3:	89 e5                	mov    %esp,%ebp
80104aa5:	e8 7e c2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104aaa:	05 16 7a 00 00       	add    $0x7a16,%eax
  asm volatile("sti");
80104aaf:	fb                   	sti    
}
80104ab0:	90                   	nop
80104ab1:	5d                   	pop    %ebp
80104ab2:	c3                   	ret    

80104ab3 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104ab3:	55                   	push   %ebp
80104ab4:	89 e5                	mov    %esp,%ebp
80104ab6:	53                   	push   %ebx
80104ab7:	83 ec 04             	sub    $0x4,%esp
80104aba:	e8 69 c2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80104abf:	05 01 7a 00 00       	add    $0x7a01,%eax
  initlock(&ptable.lock, "ptable");
80104ac4:	83 ec 08             	sub    $0x8,%esp
80104ac7:	8d 90 84 d2 ff ff    	lea    -0x2d7c(%eax),%edx
80104acd:	52                   	push   %edx
80104ace:	8d 90 c0 78 00 00    	lea    0x78c0(%eax),%edx
80104ad4:	52                   	push   %edx
80104ad5:	89 c3                	mov    %eax,%ebx
80104ad7:	e8 fa 0f 00 00       	call   80105ad6 <initlock>
80104adc:	83 c4 10             	add    $0x10,%esp
}
80104adf:	90                   	nop
80104ae0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ae3:	c9                   	leave  
80104ae4:	c3                   	ret    

80104ae5 <cpuid>:

// Must be called with interrupts disabled
int
cpuid() {
80104ae5:	55                   	push   %ebp
80104ae6:	89 e5                	mov    %esp,%ebp
80104ae8:	53                   	push   %ebx
80104ae9:	83 ec 04             	sub    $0x4,%esp
80104aec:	e8 94 b8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104af1:	81 c3 cf 79 00 00    	add    $0x79cf,%ebx
  return mycpu()-cpus;
80104af7:	e8 16 00 00 00       	call   80104b12 <mycpu>
80104afc:	c7 c2 e0 37 11 80    	mov    $0x801137e0,%edx
80104b02:	29 d0                	sub    %edx,%eax
80104b04:	c1 f8 04             	sar    $0x4,%eax
80104b07:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80104b0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b10:	c9                   	leave  
80104b11:	c3                   	ret    

80104b12 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80104b12:	55                   	push   %ebp
80104b13:	89 e5                	mov    %esp,%ebp
80104b15:	53                   	push   %ebx
80104b16:	83 ec 14             	sub    $0x14,%esp
80104b19:	e8 67 b8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104b1e:	81 c3 a2 79 00 00    	add    $0x79a2,%ebx
  int apicid, i;
  
  if(readeflags()&FL_IF)
80104b24:	e8 5f ff ff ff       	call   80104a88 <readeflags>
80104b29:	25 00 02 00 00       	and    $0x200,%eax
80104b2e:	85 c0                	test   %eax,%eax
80104b30:	74 0f                	je     80104b41 <mycpu+0x2f>
    panic("mycpu called with interrupts enabled\n");
80104b32:	83 ec 0c             	sub    $0xc,%esp
80104b35:	8d 83 8c d2 ff ff    	lea    -0x2d74(%ebx),%eax
80104b3b:	50                   	push   %eax
80104b3c:	e8 34 bb ff ff       	call   80100675 <panic>
  
  apicid = lapicid();
80104b41:	e8 37 eb ff ff       	call   8010367d <lapicid>
80104b46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80104b49:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104b50:	eb 33                	jmp    80104b85 <mycpu+0x73>
    if (cpus[i].apicid == apicid)
80104b52:	c7 c2 e0 37 11 80    	mov    $0x801137e0,%edx
80104b58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b5b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80104b61:	01 d0                	add    %edx,%eax
80104b63:	0f b6 00             	movzbl (%eax),%eax
80104b66:	0f b6 c0             	movzbl %al,%eax
80104b69:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104b6c:	75 13                	jne    80104b81 <mycpu+0x6f>
      return &cpus[i];
80104b6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b71:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
80104b77:	c7 c0 e0 37 11 80    	mov    $0x801137e0,%eax
80104b7d:	01 d0                	add    %edx,%eax
80104b7f:	eb 20                	jmp    80104ba1 <mycpu+0x8f>
  for (i = 0; i < ncpu; ++i) {
80104b81:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104b85:	c7 c0 60 3d 11 80    	mov    $0x80113d60,%eax
80104b8b:	8b 00                	mov    (%eax),%eax
80104b8d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104b90:	7c c0                	jl     80104b52 <mycpu+0x40>
  }
  panic("unknown apicid\n");
80104b92:	83 ec 0c             	sub    $0xc,%esp
80104b95:	8d 83 b2 d2 ff ff    	lea    -0x2d4e(%ebx),%eax
80104b9b:	50                   	push   %eax
80104b9c:	e8 d4 ba ff ff       	call   80100675 <panic>
}
80104ba1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba4:	c9                   	leave  
80104ba5:	c3                   	ret    

80104ba6 <myproc>:

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80104ba6:	55                   	push   %ebp
80104ba7:	89 e5                	mov    %esp,%ebp
80104ba9:	53                   	push   %ebx
80104baa:	83 ec 14             	sub    $0x14,%esp
80104bad:	e8 d3 b7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104bb2:	81 c3 0e 79 00 00    	add    $0x790e,%ebx
  struct cpu *c;
  struct proc *p;
  pushcli();
80104bb8:	e8 f6 10 00 00       	call   80105cb3 <pushcli>
  c = mycpu();
80104bbd:	e8 50 ff ff ff       	call   80104b12 <mycpu>
80104bc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  p = c->proc;
80104bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc8:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104bce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  popcli();
80104bd1:	e8 39 11 00 00       	call   80105d0f <popcli>
  return p;
80104bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104bd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bdc:	c9                   	leave  
80104bdd:	c3                   	ret    

80104bde <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104bde:	55                   	push   %ebp
80104bdf:	89 e5                	mov    %esp,%ebp
80104be1:	53                   	push   %ebx
80104be2:	83 ec 14             	sub    $0x14,%esp
80104be5:	e8 9b b7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104bea:	81 c3 d6 78 00 00    	add    $0x78d6,%ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104bf0:	83 ec 0c             	sub    $0xc,%esp
80104bf3:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80104bf9:	50                   	push   %eax
80104bfa:	e8 03 0f 00 00       	call   80105b02 <acquire>
80104bff:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c02:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
80104c08:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104c0b:	eb 0e                	jmp    80104c1b <allocproc+0x3d>
    if(p->state == UNUSED)
80104c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c10:	8b 40 0c             	mov    0xc(%eax),%eax
80104c13:	85 c0                	test   %eax,%eax
80104c15:	74 2b                	je     80104c42 <allocproc+0x64>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c17:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104c1b:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
80104c21:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104c24:	72 e7                	jb     80104c0d <allocproc+0x2f>
      goto found;

  release(&ptable.lock);
80104c26:	83 ec 0c             	sub    $0xc,%esp
80104c29:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80104c2f:	50                   	push   %eax
80104c30:	e8 48 0f 00 00       	call   80105b7d <release>
80104c35:	83 c4 10             	add    $0x10,%esp
  return 0;
80104c38:	b8 00 00 00 00       	mov    $0x0,%eax
80104c3d:	e9 b9 00 00 00       	jmp    80104cfb <allocproc+0x11d>
      goto found;
80104c42:	90                   	nop

found:
  p->state = EMBRYO;
80104c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c46:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104c4d:	8b 83 40 fb ff ff    	mov    -0x4c0(%ebx),%eax
80104c53:	8d 50 01             	lea    0x1(%eax),%edx
80104c56:	89 93 40 fb ff ff    	mov    %edx,-0x4c0(%ebx)
80104c5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c5f:	89 42 10             	mov    %eax,0x10(%edx)

  release(&ptable.lock);
80104c62:	83 ec 0c             	sub    $0xc,%esp
80104c65:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80104c6b:	50                   	push   %eax
80104c6c:	e8 0c 0f 00 00       	call   80105b7d <release>
80104c71:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104c74:	e8 20 e6 ff ff       	call   80103299 <kalloc>
80104c79:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c7c:	89 42 08             	mov    %eax,0x8(%edx)
80104c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c82:	8b 40 08             	mov    0x8(%eax),%eax
80104c85:	85 c0                	test   %eax,%eax
80104c87:	75 11                	jne    80104c9a <allocproc+0xbc>
    p->state = UNUSED;
80104c89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c8c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104c93:	b8 00 00 00 00       	mov    $0x0,%eax
80104c98:	eb 61                	jmp    80104cfb <allocproc+0x11d>
  }
  sp = p->kstack + KSTACKSIZE;
80104c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c9d:	8b 40 08             	mov    0x8(%eax),%eax
80104ca0:	05 00 10 00 00       	add    $0x1000,%eax
80104ca5:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104ca8:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104cac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104caf:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104cb2:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104cb5:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104cb9:	c7 c0 f3 73 10 80    	mov    $0x801073f3,%eax
80104cbf:	89 c2                	mov    %eax,%edx
80104cc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cc4:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104cc6:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80104cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ccd:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104cd0:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd6:	8b 40 1c             	mov    0x1c(%eax),%eax
80104cd9:	83 ec 04             	sub    $0x4,%esp
80104cdc:	6a 14                	push   $0x14
80104cde:	6a 00                	push   $0x0
80104ce0:	50                   	push   %eax
80104ce1:	e8 0e 11 00 00       	call   80105df4 <memset>
80104ce6:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cec:	8b 40 1c             	mov    0x1c(%eax),%eax
80104cef:	8d 93 24 90 ff ff    	lea    -0x6fdc(%ebx),%edx
80104cf5:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104cf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104cfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cfe:	c9                   	leave  
80104cff:	c3                   	ret    

80104d00 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	53                   	push   %ebx
80104d04:	83 ec 14             	sub    $0x14,%esp
80104d07:	e8 79 b6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104d0c:	81 c3 b4 77 00 00    	add    $0x77b4,%ebx
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80104d12:	e8 c7 fe ff ff       	call   80104bde <allocproc>
80104d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
80104d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d1d:	89 83 f4 97 00 00    	mov    %eax,0x97f4(%ebx)
  if((p->pgdir = setupkvm()) == 0)
80104d23:	e8 27 3d 00 00       	call   80108a4f <setupkvm>
80104d28:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d2b:	89 42 04             	mov    %eax,0x4(%edx)
80104d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d31:	8b 40 04             	mov    0x4(%eax),%eax
80104d34:	85 c0                	test   %eax,%eax
80104d36:	75 0f                	jne    80104d47 <userinit+0x47>
    panic("userinit: out of memory?");
80104d38:	83 ec 0c             	sub    $0xc,%esp
80104d3b:	8d 83 c2 d2 ff ff    	lea    -0x2d3e(%ebx),%eax
80104d41:	50                   	push   %eax
80104d42:	e8 2e b9 ff ff       	call   80100675 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104d47:	c7 c0 2c 00 00 00    	mov    $0x2c,%eax
80104d4d:	89 c2                	mov    %eax,%edx
80104d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d52:	8b 40 04             	mov    0x4(%eax),%eax
80104d55:	83 ec 04             	sub    $0x4,%esp
80104d58:	52                   	push   %edx
80104d59:	c7 c2 08 c4 10 80    	mov    $0x8010c408,%edx
80104d5f:	52                   	push   %edx
80104d60:	50                   	push   %eax
80104d61:	e8 92 3f 00 00       	call   80108cf8 <inituvm>
80104d66:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104d69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d6c:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d75:	8b 40 18             	mov    0x18(%eax),%eax
80104d78:	83 ec 04             	sub    $0x4,%esp
80104d7b:	6a 4c                	push   $0x4c
80104d7d:	6a 00                	push   $0x0
80104d7f:	50                   	push   %eax
80104d80:	e8 6f 10 00 00       	call   80105df4 <memset>
80104d85:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d8b:	8b 40 18             	mov    0x18(%eax),%eax
80104d8e:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d97:	8b 40 18             	mov    0x18(%eax),%eax
80104d9a:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104da0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da3:	8b 50 18             	mov    0x18(%eax),%edx
80104da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da9:	8b 40 18             	mov    0x18(%eax),%eax
80104dac:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104db0:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104db4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104db7:	8b 50 18             	mov    0x18(%eax),%edx
80104dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dbd:	8b 40 18             	mov    0x18(%eax),%eax
80104dc0:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104dc4:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dcb:	8b 40 18             	mov    0x18(%eax),%eax
80104dce:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dd8:	8b 40 18             	mov    0x18(%eax),%eax
80104ddb:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104de2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104de5:	8b 40 18             	mov    0x18(%eax),%eax
80104de8:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104def:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104df2:	8d 50 6c             	lea    0x6c(%eax),%edx
80104df5:	83 ec 04             	sub    $0x4,%esp
80104df8:	6a 10                	push   $0x10
80104dfa:	8d 83 db d2 ff ff    	lea    -0x2d25(%ebx),%eax
80104e00:	50                   	push   %eax
80104e01:	52                   	push   %edx
80104e02:	e8 2c 12 00 00       	call   80106033 <safestrcpy>
80104e07:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104e0a:	83 ec 0c             	sub    $0xc,%esp
80104e0d:	8d 83 e4 d2 ff ff    	lea    -0x2d1c(%ebx),%eax
80104e13:	50                   	push   %eax
80104e14:	e8 0d dc ff ff       	call   80102a26 <namei>
80104e19:	83 c4 10             	add    $0x10,%esp
80104e1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e1f:	89 42 68             	mov    %eax,0x68(%edx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104e22:	83 ec 0c             	sub    $0xc,%esp
80104e25:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80104e2b:	50                   	push   %eax
80104e2c:	e8 d1 0c 00 00       	call   80105b02 <acquire>
80104e31:	83 c4 10             	add    $0x10,%esp

  p->state = RUNNABLE;
80104e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e37:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80104e3e:	83 ec 0c             	sub    $0xc,%esp
80104e41:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80104e47:	50                   	push   %eax
80104e48:	e8 30 0d 00 00       	call   80105b7d <release>
80104e4d:	83 c4 10             	add    $0x10,%esp
}
80104e50:	90                   	nop
80104e51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e54:	c9                   	leave  
80104e55:	c3                   	ret    

80104e56 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104e56:	55                   	push   %ebp
80104e57:	89 e5                	mov    %esp,%ebp
80104e59:	53                   	push   %ebx
80104e5a:	83 ec 14             	sub    $0x14,%esp
80104e5d:	e8 23 b5 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104e62:	81 c3 5e 76 00 00    	add    $0x765e,%ebx
  uint sz;
  struct proc *curproc = myproc();
80104e68:	e8 39 fd ff ff       	call   80104ba6 <myproc>
80104e6d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  sz = curproc->sz;
80104e70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e73:	8b 00                	mov    (%eax),%eax
80104e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104e78:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104e7c:	7e 2e                	jle    80104eac <growproc+0x56>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104e7e:	8b 55 08             	mov    0x8(%ebp),%edx
80104e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e84:	01 c2                	add    %eax,%edx
80104e86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e89:	8b 40 04             	mov    0x4(%eax),%eax
80104e8c:	83 ec 04             	sub    $0x4,%esp
80104e8f:	52                   	push   %edx
80104e90:	ff 75 f4             	push   -0xc(%ebp)
80104e93:	50                   	push   %eax
80104e94:	e8 6c 40 00 00       	call   80108f05 <allocuvm>
80104e99:	83 c4 10             	add    $0x10,%esp
80104e9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104e9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104ea3:	75 3b                	jne    80104ee0 <growproc+0x8a>
      return -1;
80104ea5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eaa:	eb 4f                	jmp    80104efb <growproc+0xa5>
  } else if(n < 0){
80104eac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104eb0:	79 2e                	jns    80104ee0 <growproc+0x8a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104eb2:	8b 55 08             	mov    0x8(%ebp),%edx
80104eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb8:	01 c2                	add    %eax,%edx
80104eba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ebd:	8b 40 04             	mov    0x4(%eax),%eax
80104ec0:	83 ec 04             	sub    $0x4,%esp
80104ec3:	52                   	push   %edx
80104ec4:	ff 75 f4             	push   -0xc(%ebp)
80104ec7:	50                   	push   %eax
80104ec8:	e8 50 41 00 00       	call   8010901d <deallocuvm>
80104ecd:	83 c4 10             	add    $0x10,%esp
80104ed0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104ed3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104ed7:	75 07                	jne    80104ee0 <growproc+0x8a>
      return -1;
80104ed9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ede:	eb 1b                	jmp    80104efb <growproc+0xa5>
  }
  curproc->sz = sz;
80104ee0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ee3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ee6:	89 10                	mov    %edx,(%eax)
  switchuvm(curproc);
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	ff 75 f0             	push   -0x10(%ebp)
80104eee:	e8 53 3c 00 00       	call   80108b46 <switchuvm>
80104ef3:	83 c4 10             	add    $0x10,%esp
  return 0;
80104ef6:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104efb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104efe:	c9                   	leave  
80104eff:	c3                   	ret    

80104f00 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	57                   	push   %edi
80104f04:	56                   	push   %esi
80104f05:	53                   	push   %ebx
80104f06:	83 ec 1c             	sub    $0x1c,%esp
80104f09:	e8 77 b4 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80104f0e:	81 c3 b2 75 00 00    	add    $0x75b2,%ebx
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80104f14:	e8 8d fc ff ff       	call   80104ba6 <myproc>
80104f19:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // Allocate process.
  if((np = allocproc()) == 0){
80104f1c:	e8 bd fc ff ff       	call   80104bde <allocproc>
80104f21:	89 45 dc             	mov    %eax,-0x24(%ebp)
80104f24:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
80104f28:	75 0a                	jne    80104f34 <fork+0x34>
    return -1;
80104f2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f2f:	e9 4a 01 00 00       	jmp    8010507e <fork+0x17e>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104f34:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f37:	8b 10                	mov    (%eax),%edx
80104f39:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f3c:	8b 40 04             	mov    0x4(%eax),%eax
80104f3f:	83 ec 08             	sub    $0x8,%esp
80104f42:	52                   	push   %edx
80104f43:	50                   	push   %eax
80104f44:	e8 a5 42 00 00       	call   801091ee <copyuvm>
80104f49:	83 c4 10             	add    $0x10,%esp
80104f4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104f4f:	89 42 04             	mov    %eax,0x4(%edx)
80104f52:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f55:	8b 40 04             	mov    0x4(%eax),%eax
80104f58:	85 c0                	test   %eax,%eax
80104f5a:	75 30                	jne    80104f8c <fork+0x8c>
    kfree(np->kstack);
80104f5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f5f:	8b 40 08             	mov    0x8(%eax),%eax
80104f62:	83 ec 0c             	sub    $0xc,%esp
80104f65:	50                   	push   %eax
80104f66:	e8 7a e2 ff ff       	call   801031e5 <kfree>
80104f6b:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104f6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f71:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104f78:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f7b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104f82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f87:	e9 f2 00 00 00       	jmp    8010507e <fork+0x17e>
  }
  np->sz = curproc->sz;
80104f8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f8f:	8b 10                	mov    (%eax),%edx
80104f91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f94:	89 10                	mov    %edx,(%eax)
  np->parent = curproc;
80104f96:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f99:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104f9c:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *curproc->tf;
80104f9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fa2:	8b 48 18             	mov    0x18(%eax),%ecx
80104fa5:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104fa8:	8b 40 18             	mov    0x18(%eax),%eax
80104fab:	89 c2                	mov    %eax,%edx
80104fad:	89 ce                	mov    %ecx,%esi
80104faf:	b8 13 00 00 00       	mov    $0x13,%eax
80104fb4:	89 d7                	mov    %edx,%edi
80104fb6:	89 c1                	mov    %eax,%ecx
80104fb8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104fba:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104fbd:	8b 40 18             	mov    0x18(%eax),%eax
80104fc0:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104fc7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104fce:	eb 3b                	jmp    8010500b <fork+0x10b>
    if(curproc->ofile[i])
80104fd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fd3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104fd6:	83 c2 08             	add    $0x8,%edx
80104fd9:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104fdd:	85 c0                	test   %eax,%eax
80104fdf:	74 26                	je     80105007 <fork+0x107>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104fe1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fe4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104fe7:	83 c2 08             	add    $0x8,%edx
80104fea:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104fee:	83 ec 0c             	sub    $0xc,%esp
80104ff1:	50                   	push   %eax
80104ff2:	e8 64 c3 ff ff       	call   8010135b <filedup>
80104ff7:	83 c4 10             	add    $0x10,%esp
80104ffa:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104ffd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105000:	83 c1 08             	add    $0x8,%ecx
80105003:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  for(i = 0; i < NOFILE; i++)
80105007:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010500b:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
8010500f:	7e bf                	jle    80104fd0 <fork+0xd0>
  np->cwd = idup(curproc->cwd);
80105011:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105014:	8b 40 68             	mov    0x68(%eax),%eax
80105017:	83 ec 0c             	sub    $0xc,%esp
8010501a:	50                   	push   %eax
8010501b:	e8 8b cd ff ff       	call   80101dab <idup>
80105020:	83 c4 10             	add    $0x10,%esp
80105023:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105026:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80105029:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010502c:	8d 50 6c             	lea    0x6c(%eax),%edx
8010502f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105032:	83 c0 6c             	add    $0x6c,%eax
80105035:	83 ec 04             	sub    $0x4,%esp
80105038:	6a 10                	push   $0x10
8010503a:	52                   	push   %edx
8010503b:	50                   	push   %eax
8010503c:	e8 f2 0f 00 00       	call   80106033 <safestrcpy>
80105041:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
80105044:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105047:	8b 40 10             	mov    0x10(%eax),%eax
8010504a:	89 45 d8             	mov    %eax,-0x28(%ebp)

  acquire(&ptable.lock);
8010504d:	83 ec 0c             	sub    $0xc,%esp
80105050:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105056:	50                   	push   %eax
80105057:	e8 a6 0a 00 00       	call   80105b02 <acquire>
8010505c:	83 c4 10             	add    $0x10,%esp

  np->state = RUNNABLE;
8010505f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105062:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105072:	50                   	push   %eax
80105073:	e8 05 0b 00 00       	call   80105b7d <release>
80105078:	83 c4 10             	add    $0x10,%esp

  return pid;
8010507b:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
8010507e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105081:	5b                   	pop    %ebx
80105082:	5e                   	pop    %esi
80105083:	5f                   	pop    %edi
80105084:	5d                   	pop    %ebp
80105085:	c3                   	ret    

80105086 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80105086:	55                   	push   %ebp
80105087:	89 e5                	mov    %esp,%ebp
80105089:	53                   	push   %ebx
8010508a:	83 ec 14             	sub    $0x14,%esp
8010508d:	e8 f3 b2 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105092:	81 c3 2e 74 00 00    	add    $0x742e,%ebx
  struct proc *curproc = myproc();
80105098:	e8 09 fb ff ff       	call   80104ba6 <myproc>
8010509d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct proc *p;
  int fd;

  if(curproc == initproc)
801050a0:	8b 83 f4 97 00 00    	mov    0x97f4(%ebx),%eax
801050a6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
801050a9:	75 0f                	jne    801050ba <exit+0x34>
    panic("init exiting");
801050ab:	83 ec 0c             	sub    $0xc,%esp
801050ae:	8d 83 e6 d2 ff ff    	lea    -0x2d1a(%ebx),%eax
801050b4:	50                   	push   %eax
801050b5:	e8 bb b5 ff ff       	call   80100675 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801050ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801050c1:	eb 3f                	jmp    80105102 <exit+0x7c>
    if(curproc->ofile[fd]){
801050c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801050c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801050c9:	83 c2 08             	add    $0x8,%edx
801050cc:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801050d0:	85 c0                	test   %eax,%eax
801050d2:	74 2a                	je     801050fe <exit+0x78>
      fileclose(curproc->ofile[fd]);
801050d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801050d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801050da:	83 c2 08             	add    $0x8,%edx
801050dd:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801050e1:	83 ec 0c             	sub    $0xc,%esp
801050e4:	50                   	push   %eax
801050e5:	e8 d7 c2 ff ff       	call   801013c1 <fileclose>
801050ea:	83 c4 10             	add    $0x10,%esp
      curproc->ofile[fd] = 0;
801050ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801050f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801050f3:	83 c2 08             	add    $0x8,%edx
801050f6:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801050fd:	00 
  for(fd = 0; fd < NOFILE; fd++){
801050fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80105102:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80105106:	7e bb                	jle    801050c3 <exit+0x3d>
    }
  }

  begin_op();
80105108:	e8 5c eb ff ff       	call   80103c69 <begin_op>
  iput(curproc->cwd);
8010510d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105110:	8b 40 68             	mov    0x68(%eax),%eax
80105113:	83 ec 0c             	sub    $0xc,%esp
80105116:	50                   	push   %eax
80105117:	e8 62 ce ff ff       	call   80101f7e <iput>
8010511c:	83 c4 10             	add    $0x10,%esp
  end_op();
8010511f:	e8 f0 eb ff ff       	call   80103d14 <end_op>
  curproc->cwd = 0;
80105124:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105127:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
8010512e:	83 ec 0c             	sub    $0xc,%esp
80105131:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105137:	50                   	push   %eax
80105138:	e8 c5 09 00 00       	call   80105b02 <acquire>
8010513d:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80105140:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105143:	8b 40 14             	mov    0x14(%eax),%eax
80105146:	83 ec 0c             	sub    $0xc,%esp
80105149:	50                   	push   %eax
8010514a:	e8 af 04 00 00       	call   801055fe <wakeup1>
8010514f:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105152:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
80105158:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010515b:	eb 38                	jmp    80105195 <exit+0x10f>
    if(p->parent == curproc){
8010515d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105160:	8b 40 14             	mov    0x14(%eax),%eax
80105163:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80105166:	75 29                	jne    80105191 <exit+0x10b>
      p->parent = initproc;
80105168:	8b 93 f4 97 00 00    	mov    0x97f4(%ebx),%edx
8010516e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105171:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80105174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105177:	8b 40 0c             	mov    0xc(%eax),%eax
8010517a:	83 f8 05             	cmp    $0x5,%eax
8010517d:	75 12                	jne    80105191 <exit+0x10b>
        wakeup1(initproc);
8010517f:	8b 83 f4 97 00 00    	mov    0x97f4(%ebx),%eax
80105185:	83 ec 0c             	sub    $0xc,%esp
80105188:	50                   	push   %eax
80105189:	e8 70 04 00 00       	call   801055fe <wakeup1>
8010518e:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105191:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80105195:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
8010519b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010519e:	72 bd                	jb     8010515d <exit+0xd7>
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
801051a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801051a3:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801051aa:	e8 16 02 00 00       	call   801053c5 <sched>
  panic("zombie exit");
801051af:	83 ec 0c             	sub    $0xc,%esp
801051b2:	8d 83 f3 d2 ff ff    	lea    -0x2d0d(%ebx),%eax
801051b8:	50                   	push   %eax
801051b9:	e8 b7 b4 ff ff       	call   80100675 <panic>

801051be <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801051be:	55                   	push   %ebp
801051bf:	89 e5                	mov    %esp,%ebp
801051c1:	53                   	push   %ebx
801051c2:	83 ec 14             	sub    $0x14,%esp
801051c5:	e8 bb b1 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801051ca:	81 c3 f6 72 00 00    	add    $0x72f6,%ebx
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
801051d0:	e8 d1 f9 ff ff       	call   80104ba6 <myproc>
801051d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
  acquire(&ptable.lock);
801051d8:	83 ec 0c             	sub    $0xc,%esp
801051db:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801051e1:	50                   	push   %eax
801051e2:	e8 1b 09 00 00       	call   80105b02 <acquire>
801051e7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801051ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801051f1:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
801051f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801051fa:	e9 a3 00 00 00       	jmp    801052a2 <wait+0xe4>
      if(p->parent != curproc)
801051ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105202:	8b 40 14             	mov    0x14(%eax),%eax
80105205:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80105208:	0f 85 8f 00 00 00    	jne    8010529d <wait+0xdf>
        continue;
      havekids = 1;
8010520e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80105215:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105218:	8b 40 0c             	mov    0xc(%eax),%eax
8010521b:	83 f8 05             	cmp    $0x5,%eax
8010521e:	75 7e                	jne    8010529e <wait+0xe0>
        // Found one.
        pid = p->pid;
80105220:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105223:	8b 40 10             	mov    0x10(%eax),%eax
80105226:	89 45 e8             	mov    %eax,-0x18(%ebp)
        kfree(p->kstack);
80105229:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010522c:	8b 40 08             	mov    0x8(%eax),%eax
8010522f:	83 ec 0c             	sub    $0xc,%esp
80105232:	50                   	push   %eax
80105233:	e8 ad df ff ff       	call   801031e5 <kfree>
80105238:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
8010523b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010523e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80105245:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105248:	8b 40 04             	mov    0x4(%eax),%eax
8010524b:	83 ec 0c             	sub    $0xc,%esp
8010524e:	50                   	push   %eax
8010524f:	e8 9e 3e 00 00       	call   801090f2 <freevm>
80105254:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80105257:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010525a:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80105261:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105264:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010526b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010526e:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80105272:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105275:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
8010527c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010527f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80105286:	83 ec 0c             	sub    $0xc,%esp
80105289:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
8010528f:	50                   	push   %eax
80105290:	e8 e8 08 00 00       	call   80105b7d <release>
80105295:	83 c4 10             	add    $0x10,%esp
        return pid;
80105298:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010529b:	eb 57                	jmp    801052f4 <wait+0x136>
        continue;
8010529d:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010529e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801052a2:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
801052a8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801052ab:	0f 82 4e ff ff ff    	jb     801051ff <wait+0x41>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
801052b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801052b5:	74 0a                	je     801052c1 <wait+0x103>
801052b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052ba:	8b 40 24             	mov    0x24(%eax),%eax
801052bd:	85 c0                	test   %eax,%eax
801052bf:	74 19                	je     801052da <wait+0x11c>
      release(&ptable.lock);
801052c1:	83 ec 0c             	sub    $0xc,%esp
801052c4:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801052ca:	50                   	push   %eax
801052cb:	e8 ad 08 00 00       	call   80105b7d <release>
801052d0:	83 c4 10             	add    $0x10,%esp
      return -1;
801052d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052d8:	eb 1a                	jmp    801052f4 <wait+0x136>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801052da:	83 ec 08             	sub    $0x8,%esp
801052dd:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801052e3:	50                   	push   %eax
801052e4:	ff 75 ec             	push   -0x14(%ebp)
801052e7:	e8 50 02 00 00       	call   8010553c <sleep>
801052ec:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801052ef:	e9 f6 fe ff ff       	jmp    801051ea <wait+0x2c>
  }
}
801052f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052f7:	c9                   	leave  
801052f8:	c3                   	ret    

801052f9 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801052f9:	55                   	push   %ebp
801052fa:	89 e5                	mov    %esp,%ebp
801052fc:	53                   	push   %ebx
801052fd:	83 ec 14             	sub    $0x14,%esp
80105300:	e8 80 b0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105305:	81 c3 bb 71 00 00    	add    $0x71bb,%ebx
  struct proc *p;
  struct cpu *c = mycpu();
8010530b:	e8 02 f8 ff ff       	call   80104b12 <mycpu>
80105310:	89 45 f0             	mov    %eax,-0x10(%ebp)
  c->proc = 0;
80105313:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105316:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010531d:	00 00 00 
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
80105320:	e8 7d f7 ff ff       	call   80104aa2 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80105325:	83 ec 0c             	sub    $0xc,%esp
80105328:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
8010532e:	50                   	push   %eax
8010532f:	e8 ce 07 00 00       	call   80105b02 <acquire>
80105334:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105337:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
8010533d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105340:	eb 61                	jmp    801053a3 <scheduler+0xaa>
      if(p->state != RUNNABLE)
80105342:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105345:	8b 40 0c             	mov    0xc(%eax),%eax
80105348:	83 f8 03             	cmp    $0x3,%eax
8010534b:	75 51                	jne    8010539e <scheduler+0xa5>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
8010534d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105350:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105353:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
      switchuvm(p);
80105359:	83 ec 0c             	sub    $0xc,%esp
8010535c:	ff 75 f4             	push   -0xc(%ebp)
8010535f:	e8 e2 37 00 00       	call   80108b46 <switchuvm>
80105364:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80105367:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010536a:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

      swtch(&(c->scheduler), p->context);
80105371:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105374:	8b 40 1c             	mov    0x1c(%eax),%eax
80105377:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010537a:	83 c2 04             	add    $0x4,%edx
8010537d:	83 ec 08             	sub    $0x8,%esp
80105380:	50                   	push   %eax
80105381:	52                   	push   %edx
80105382:	e8 32 0d 00 00       	call   801060b9 <swtch>
80105387:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010538a:	e8 93 37 00 00       	call   80108b22 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
8010538f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105392:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80105399:	00 00 00 
8010539c:	eb 01                	jmp    8010539f <scheduler+0xa6>
        continue;
8010539e:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010539f:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801053a3:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
801053a9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801053ac:	72 94                	jb     80105342 <scheduler+0x49>
    }
    release(&ptable.lock);
801053ae:	83 ec 0c             	sub    $0xc,%esp
801053b1:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801053b7:	50                   	push   %eax
801053b8:	e8 c0 07 00 00       	call   80105b7d <release>
801053bd:	83 c4 10             	add    $0x10,%esp
    sti();
801053c0:	e9 5b ff ff ff       	jmp    80105320 <scheduler+0x27>

801053c5 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
801053c5:	55                   	push   %ebp
801053c6:	89 e5                	mov    %esp,%ebp
801053c8:	53                   	push   %ebx
801053c9:	83 ec 14             	sub    $0x14,%esp
801053cc:	e8 b4 af ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801053d1:	81 c3 ef 70 00 00    	add    $0x70ef,%ebx
  int intena;
  struct proc *p = myproc();
801053d7:	e8 ca f7 ff ff       	call   80104ba6 <myproc>
801053dc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(!holding(&ptable.lock))
801053df:	83 ec 0c             	sub    $0xc,%esp
801053e2:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801053e8:	50                   	push   %eax
801053e9:	e8 77 08 00 00       	call   80105c65 <holding>
801053ee:	83 c4 10             	add    $0x10,%esp
801053f1:	85 c0                	test   %eax,%eax
801053f3:	75 0f                	jne    80105404 <sched+0x3f>
    panic("sched ptable.lock");
801053f5:	83 ec 0c             	sub    $0xc,%esp
801053f8:	8d 83 ff d2 ff ff    	lea    -0x2d01(%ebx),%eax
801053fe:	50                   	push   %eax
801053ff:	e8 71 b2 ff ff       	call   80100675 <panic>
  if(mycpu()->ncli != 1)
80105404:	e8 09 f7 ff ff       	call   80104b12 <mycpu>
80105409:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010540f:	83 f8 01             	cmp    $0x1,%eax
80105412:	74 0f                	je     80105423 <sched+0x5e>
    panic("sched locks");
80105414:	83 ec 0c             	sub    $0xc,%esp
80105417:	8d 83 11 d3 ff ff    	lea    -0x2cef(%ebx),%eax
8010541d:	50                   	push   %eax
8010541e:	e8 52 b2 ff ff       	call   80100675 <panic>
  if(p->state == RUNNING)
80105423:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105426:	8b 40 0c             	mov    0xc(%eax),%eax
80105429:	83 f8 04             	cmp    $0x4,%eax
8010542c:	75 0f                	jne    8010543d <sched+0x78>
    panic("sched running");
8010542e:	83 ec 0c             	sub    $0xc,%esp
80105431:	8d 83 1d d3 ff ff    	lea    -0x2ce3(%ebx),%eax
80105437:	50                   	push   %eax
80105438:	e8 38 b2 ff ff       	call   80100675 <panic>
  if(readeflags()&FL_IF)
8010543d:	e8 46 f6 ff ff       	call   80104a88 <readeflags>
80105442:	25 00 02 00 00       	and    $0x200,%eax
80105447:	85 c0                	test   %eax,%eax
80105449:	74 0f                	je     8010545a <sched+0x95>
    panic("sched interruptible");
8010544b:	83 ec 0c             	sub    $0xc,%esp
8010544e:	8d 83 2b d3 ff ff    	lea    -0x2cd5(%ebx),%eax
80105454:	50                   	push   %eax
80105455:	e8 1b b2 ff ff       	call   80100675 <panic>
  intena = mycpu()->intena;
8010545a:	e8 b3 f6 ff ff       	call   80104b12 <mycpu>
8010545f:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105465:	89 45 f0             	mov    %eax,-0x10(%ebp)
  swtch(&p->context, mycpu()->scheduler);
80105468:	e8 a5 f6 ff ff       	call   80104b12 <mycpu>
8010546d:	8b 40 04             	mov    0x4(%eax),%eax
80105470:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105473:	83 c2 1c             	add    $0x1c,%edx
80105476:	83 ec 08             	sub    $0x8,%esp
80105479:	50                   	push   %eax
8010547a:	52                   	push   %edx
8010547b:	e8 39 0c 00 00       	call   801060b9 <swtch>
80105480:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80105483:	e8 8a f6 ff ff       	call   80104b12 <mycpu>
80105488:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010548b:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
}
80105491:	90                   	nop
80105492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105495:	c9                   	leave  
80105496:	c3                   	ret    

80105497 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80105497:	55                   	push   %ebp
80105498:	89 e5                	mov    %esp,%ebp
8010549a:	53                   	push   %ebx
8010549b:	83 ec 04             	sub    $0x4,%esp
8010549e:	e8 e2 ae ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801054a3:	81 c3 1d 70 00 00    	add    $0x701d,%ebx
  acquire(&ptable.lock);  //DOC: yieldlock
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801054b2:	50                   	push   %eax
801054b3:	e8 4a 06 00 00       	call   80105b02 <acquire>
801054b8:	83 c4 10             	add    $0x10,%esp
  myproc()->state = RUNNABLE;
801054bb:	e8 e6 f6 ff ff       	call   80104ba6 <myproc>
801054c0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801054c7:	e8 f9 fe ff ff       	call   801053c5 <sched>
  release(&ptable.lock);
801054cc:	83 ec 0c             	sub    $0xc,%esp
801054cf:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801054d5:	50                   	push   %eax
801054d6:	e8 a2 06 00 00       	call   80105b7d <release>
801054db:	83 c4 10             	add    $0x10,%esp
}
801054de:	90                   	nop
801054df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054e2:	c9                   	leave  
801054e3:	c3                   	ret    

801054e4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801054e4:	55                   	push   %ebp
801054e5:	89 e5                	mov    %esp,%ebp
801054e7:	53                   	push   %ebx
801054e8:	83 ec 04             	sub    $0x4,%esp
801054eb:	e8 95 ae ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801054f0:	81 c3 d0 6f 00 00    	add    $0x6fd0,%ebx
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801054f6:	83 ec 0c             	sub    $0xc,%esp
801054f9:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801054ff:	50                   	push   %eax
80105500:	e8 78 06 00 00       	call   80105b7d <release>
80105505:	83 c4 10             	add    $0x10,%esp

  if (first) {
80105508:	8b 83 44 fb ff ff    	mov    -0x4bc(%ebx),%eax
8010550e:	85 c0                	test   %eax,%eax
80105510:	74 24                	je     80105536 <forkret+0x52>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80105512:	c7 83 44 fb ff ff 00 	movl   $0x0,-0x4bc(%ebx)
80105519:	00 00 00 
    iinit(ROOTDEV);
8010551c:	83 ec 0c             	sub    $0xc,%esp
8010551f:	6a 01                	push   $0x1
80105521:	e8 f1 c4 ff ff       	call   80101a17 <iinit>
80105526:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80105529:	83 ec 0c             	sub    $0xc,%esp
8010552c:	6a 01                	push   $0x1
8010552e:	e8 bb e4 ff ff       	call   801039ee <initlog>
80105533:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80105536:	90                   	nop
80105537:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010553a:	c9                   	leave  
8010553b:	c3                   	ret    

8010553c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
8010553c:	55                   	push   %ebp
8010553d:	89 e5                	mov    %esp,%ebp
8010553f:	53                   	push   %ebx
80105540:	83 ec 14             	sub    $0x14,%esp
80105543:	e8 3d ae ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105548:	81 c3 78 6f 00 00    	add    $0x6f78,%ebx
  struct proc *p = myproc();
8010554e:	e8 53 f6 ff ff       	call   80104ba6 <myproc>
80105553:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  if(p == 0)
80105556:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010555a:	75 0f                	jne    8010556b <sleep+0x2f>
    panic("sleep");
8010555c:	83 ec 0c             	sub    $0xc,%esp
8010555f:	8d 83 3f d3 ff ff    	lea    -0x2cc1(%ebx),%eax
80105565:	50                   	push   %eax
80105566:	e8 0a b1 ff ff       	call   80100675 <panic>

  if(lk == 0)
8010556b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010556f:	75 0f                	jne    80105580 <sleep+0x44>
    panic("sleep without lk");
80105571:	83 ec 0c             	sub    $0xc,%esp
80105574:	8d 83 45 d3 ff ff    	lea    -0x2cbb(%ebx),%eax
8010557a:	50                   	push   %eax
8010557b:	e8 f5 b0 ff ff       	call   80100675 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80105580:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105586:	39 45 0c             	cmp    %eax,0xc(%ebp)
80105589:	74 20                	je     801055ab <sleep+0x6f>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010558b:	83 ec 0c             	sub    $0xc,%esp
8010558e:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105594:	50                   	push   %eax
80105595:	e8 68 05 00 00       	call   80105b02 <acquire>
8010559a:	83 c4 10             	add    $0x10,%esp
    release(lk);
8010559d:	83 ec 0c             	sub    $0xc,%esp
801055a0:	ff 75 0c             	push   0xc(%ebp)
801055a3:	e8 d5 05 00 00       	call   80105b7d <release>
801055a8:	83 c4 10             	add    $0x10,%esp
  }
  // Go to sleep.
  p->chan = chan;
801055ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055ae:	8b 55 08             	mov    0x8(%ebp),%edx
801055b1:	89 50 20             	mov    %edx,0x20(%eax)
  p->state = SLEEPING;
801055b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055b7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
801055be:	e8 02 fe ff ff       	call   801053c5 <sched>

  // Tidy up.
  p->chan = 0;
801055c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055c6:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
801055cd:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801055d3:	39 45 0c             	cmp    %eax,0xc(%ebp)
801055d6:	74 20                	je     801055f8 <sleep+0xbc>
    release(&ptable.lock);
801055d8:	83 ec 0c             	sub    $0xc,%esp
801055db:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801055e1:	50                   	push   %eax
801055e2:	e8 96 05 00 00       	call   80105b7d <release>
801055e7:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
801055ea:	83 ec 0c             	sub    $0xc,%esp
801055ed:	ff 75 0c             	push   0xc(%ebp)
801055f0:	e8 0d 05 00 00       	call   80105b02 <acquire>
801055f5:	83 c4 10             	add    $0x10,%esp
  }
}
801055f8:	90                   	nop
801055f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055fc:	c9                   	leave  
801055fd:	c3                   	ret    

801055fe <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
801055fe:	55                   	push   %ebp
801055ff:	89 e5                	mov    %esp,%ebp
80105601:	83 ec 10             	sub    $0x10,%esp
80105604:	e8 1f b7 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105609:	05 b7 6e 00 00       	add    $0x6eb7,%eax
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010560e:	8d 90 f4 78 00 00    	lea    0x78f4(%eax),%edx
80105614:	89 55 fc             	mov    %edx,-0x4(%ebp)
80105617:	eb 24                	jmp    8010563d <wakeup1+0x3f>
    if(p->state == SLEEPING && p->chan == chan)
80105619:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010561c:	8b 52 0c             	mov    0xc(%edx),%edx
8010561f:	83 fa 02             	cmp    $0x2,%edx
80105622:	75 15                	jne    80105639 <wakeup1+0x3b>
80105624:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105627:	8b 52 20             	mov    0x20(%edx),%edx
8010562a:	39 55 08             	cmp    %edx,0x8(%ebp)
8010562d:	75 0a                	jne    80105639 <wakeup1+0x3b>
      p->state = RUNNABLE;
8010562f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105632:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105639:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
8010563d:	8d 90 f4 97 00 00    	lea    0x97f4(%eax),%edx
80105643:	39 55 fc             	cmp    %edx,-0x4(%ebp)
80105646:	72 d1                	jb     80105619 <wakeup1+0x1b>
}
80105648:	90                   	nop
80105649:	90                   	nop
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    

8010564c <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
8010564c:	55                   	push   %ebp
8010564d:	89 e5                	mov    %esp,%ebp
8010564f:	53                   	push   %ebx
80105650:	83 ec 04             	sub    $0x4,%esp
80105653:	e8 2d ad ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105658:	81 c3 68 6e 00 00    	add    $0x6e68,%ebx
  acquire(&ptable.lock);
8010565e:	83 ec 0c             	sub    $0xc,%esp
80105661:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105667:	50                   	push   %eax
80105668:	e8 95 04 00 00       	call   80105b02 <acquire>
8010566d:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	ff 75 08             	push   0x8(%ebp)
80105676:	e8 83 ff ff ff       	call   801055fe <wakeup1>
8010567b:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
8010567e:	83 ec 0c             	sub    $0xc,%esp
80105681:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105687:	50                   	push   %eax
80105688:	e8 f0 04 00 00       	call   80105b7d <release>
8010568d:	83 c4 10             	add    $0x10,%esp
}
80105690:	90                   	nop
80105691:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105694:	c9                   	leave  
80105695:	c3                   	ret    

80105696 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80105696:	55                   	push   %ebp
80105697:	89 e5                	mov    %esp,%ebp
80105699:	53                   	push   %ebx
8010569a:	83 ec 14             	sub    $0x14,%esp
8010569d:	e8 e3 ac ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801056a2:	81 c3 1e 6e 00 00    	add    $0x6e1e,%ebx
  struct proc *p;

  acquire(&ptable.lock);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801056b1:	50                   	push   %eax
801056b2:	e8 4b 04 00 00       	call   80105b02 <acquire>
801056b7:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801056ba:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
801056c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056c3:	eb 47                	jmp    8010570c <kill+0x76>
    if(p->pid == pid){
801056c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056c8:	8b 40 10             	mov    0x10(%eax),%eax
801056cb:	39 45 08             	cmp    %eax,0x8(%ebp)
801056ce:	75 38                	jne    80105708 <kill+0x72>
      p->killed = 1;
801056d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801056da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056dd:	8b 40 0c             	mov    0xc(%eax),%eax
801056e0:	83 f8 02             	cmp    $0x2,%eax
801056e3:	75 0a                	jne    801056ef <kill+0x59>
        p->state = RUNNABLE;
801056e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056e8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801056ef:	83 ec 0c             	sub    $0xc,%esp
801056f2:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
801056f8:	50                   	push   %eax
801056f9:	e8 7f 04 00 00       	call   80105b7d <release>
801056fe:	83 c4 10             	add    $0x10,%esp
      return 0;
80105701:	b8 00 00 00 00       	mov    $0x0,%eax
80105706:	eb 26                	jmp    8010572e <kill+0x98>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105708:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010570c:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
80105712:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80105715:	72 ae                	jb     801056c5 <kill+0x2f>
    }
  }
  release(&ptable.lock);
80105717:	83 ec 0c             	sub    $0xc,%esp
8010571a:	8d 83 c0 78 00 00    	lea    0x78c0(%ebx),%eax
80105720:	50                   	push   %eax
80105721:	e8 57 04 00 00       	call   80105b7d <release>
80105726:	83 c4 10             	add    $0x10,%esp
  return -1;
80105729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010572e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105731:	c9                   	leave  
80105732:	c3                   	ret    

80105733 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105733:	55                   	push   %ebp
80105734:	89 e5                	mov    %esp,%ebp
80105736:	53                   	push   %ebx
80105737:	83 ec 44             	sub    $0x44,%esp
8010573a:	e8 46 ac ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010573f:	81 c3 81 6d 00 00    	add    $0x6d81,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105745:	8d 83 f4 78 00 00    	lea    0x78f4(%ebx),%eax
8010574b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010574e:	e9 df 00 00 00       	jmp    80105832 <procdump+0xff>
    if(p->state == UNUSED)
80105753:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105756:	8b 40 0c             	mov    0xc(%eax),%eax
80105759:	85 c0                	test   %eax,%eax
8010575b:	0f 84 cc 00 00 00    	je     8010582d <procdump+0xfa>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105761:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105764:	8b 40 0c             	mov    0xc(%eax),%eax
80105767:	83 f8 05             	cmp    $0x5,%eax
8010576a:	77 23                	ja     8010578f <procdump+0x5c>
8010576c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010576f:	8b 40 0c             	mov    0xc(%eax),%eax
80105772:	8b 84 83 1c 00 00 00 	mov    0x1c(%ebx,%eax,4),%eax
80105779:	85 c0                	test   %eax,%eax
8010577b:	74 12                	je     8010578f <procdump+0x5c>
      state = states[p->state];
8010577d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105780:	8b 40 0c             	mov    0xc(%eax),%eax
80105783:	8b 84 83 1c 00 00 00 	mov    0x1c(%ebx,%eax,4),%eax
8010578a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010578d:	eb 09                	jmp    80105798 <procdump+0x65>
    else
      state = "???";
8010578f:	8d 83 56 d3 ff ff    	lea    -0x2caa(%ebx),%eax
80105795:	89 45 ec             	mov    %eax,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80105798:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010579b:	8d 50 6c             	lea    0x6c(%eax),%edx
8010579e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057a1:	8b 40 10             	mov    0x10(%eax),%eax
801057a4:	52                   	push   %edx
801057a5:	ff 75 ec             	push   -0x14(%ebp)
801057a8:	50                   	push   %eax
801057a9:	8d 83 5a d3 ff ff    	lea    -0x2ca6(%ebx),%eax
801057af:	50                   	push   %eax
801057b0:	e8 f3 ac ff ff       	call   801004a8 <cprintf>
801057b5:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
801057b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057bb:	8b 40 0c             	mov    0xc(%eax),%eax
801057be:	83 f8 02             	cmp    $0x2,%eax
801057c1:	75 56                	jne    80105819 <procdump+0xe6>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801057c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057c6:	8b 40 1c             	mov    0x1c(%eax),%eax
801057c9:	8b 40 0c             	mov    0xc(%eax),%eax
801057cc:	83 c0 08             	add    $0x8,%eax
801057cf:	89 c2                	mov    %eax,%edx
801057d1:	83 ec 08             	sub    $0x8,%esp
801057d4:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801057d7:	50                   	push   %eax
801057d8:	52                   	push   %edx
801057d9:	e8 02 04 00 00       	call   80105be0 <getcallerpcs>
801057de:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801057e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801057e8:	eb 1e                	jmp    80105808 <procdump+0xd5>
        cprintf(" %p", pc[i]);
801057ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057ed:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801057f1:	83 ec 08             	sub    $0x8,%esp
801057f4:	50                   	push   %eax
801057f5:	8d 83 63 d3 ff ff    	lea    -0x2c9d(%ebx),%eax
801057fb:	50                   	push   %eax
801057fc:	e8 a7 ac ff ff       	call   801004a8 <cprintf>
80105801:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105804:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105808:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010580c:	7f 0b                	jg     80105819 <procdump+0xe6>
8010580e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105811:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105815:	85 c0                	test   %eax,%eax
80105817:	75 d1                	jne    801057ea <procdump+0xb7>
    }
    cprintf("\n");
80105819:	83 ec 0c             	sub    $0xc,%esp
8010581c:	8d 83 67 d3 ff ff    	lea    -0x2c99(%ebx),%eax
80105822:	50                   	push   %eax
80105823:	e8 80 ac ff ff       	call   801004a8 <cprintf>
80105828:	83 c4 10             	add    $0x10,%esp
8010582b:	eb 01                	jmp    8010582e <procdump+0xfb>
      continue;
8010582d:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010582e:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80105832:	8d 83 f4 97 00 00    	lea    0x97f4(%ebx),%eax
80105838:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010583b:	0f 82 12 ff ff ff    	jb     80105753 <procdump+0x20>
  }
}
80105841:	90                   	nop
80105842:	90                   	nop
80105843:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105846:	c9                   	leave  
80105847:	c3                   	ret    

80105848 <random>:


int random(void){
80105848:	55                   	push   %ebp
80105849:	89 e5                	mov    %esp,%ebp
8010584b:	53                   	push   %ebx
8010584c:	83 ec 10             	sub    $0x10,%esp
8010584f:	e8 d8 b4 ff ff       	call   80100d2c <__x86.get_pc_thunk.cx>
80105854:	81 c1 6c 6c 00 00    	add    $0x6c6c,%ecx
  int x=ticks;
8010585a:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
80105860:	8b 00                	mov    (%eax),%eax
80105862:	89 45 f8             	mov    %eax,-0x8(%ebp)
  x=x*x;
80105865:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105868:	0f af c0             	imul   %eax,%eax
8010586b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  // x=x%10;
  int a=1019;
8010586e:	c7 45 f0 fb 03 00 00 	movl   $0x3fb,-0x10(%ebp)
  int b=10247693;
80105875:	c7 45 ec 0d 5e 9c 00 	movl   $0x9c5e0d,-0x14(%ebp)
  for(int i=0;i<ticks%17;i++){
8010587c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80105883:	eb 13                	jmp    80105898 <random+0x50>
    x=(x+b)%a;
80105885:	8b 55 f8             	mov    -0x8(%ebp),%edx
80105888:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010588b:	01 d0                	add    %edx,%eax
8010588d:	99                   	cltd   
8010588e:	f7 7d f0             	idivl  -0x10(%ebp)
80105891:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(int i=0;i<ticks%17;i++){
80105894:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105898:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
8010589e:	8b 18                	mov    (%eax),%ebx
801058a0:	ba f1 f0 f0 f0       	mov    $0xf0f0f0f1,%edx
801058a5:	89 d8                	mov    %ebx,%eax
801058a7:	f7 e2                	mul    %edx
801058a9:	89 d0                	mov    %edx,%eax
801058ab:	c1 e8 04             	shr    $0x4,%eax
801058ae:	89 c2                	mov    %eax,%edx
801058b0:	c1 e2 04             	shl    $0x4,%edx
801058b3:	01 c2                	add    %eax,%edx
801058b5:	89 d8                	mov    %ebx,%eax
801058b7:	29 d0                	sub    %edx,%eax
801058b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058bc:	39 d0                	cmp    %edx,%eax
801058be:	77 c5                	ja     80105885 <random+0x3d>
  }
  x=x%1000000007;
801058c0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
801058c3:	ba 99 2f b8 44       	mov    $0x44b82f99,%edx
801058c8:	89 c8                	mov    %ecx,%eax
801058ca:	f7 ea                	imul   %edx
801058cc:	89 d0                	mov    %edx,%eax
801058ce:	c1 f8 1c             	sar    $0x1c,%eax
801058d1:	89 ca                	mov    %ecx,%edx
801058d3:	c1 fa 1f             	sar    $0x1f,%edx
801058d6:	29 d0                	sub    %edx,%eax
801058d8:	69 d0 07 ca 9a 3b    	imul   $0x3b9aca07,%eax,%edx
801058de:	89 c8                	mov    %ecx,%eax
801058e0:	29 d0                	sub    %edx,%eax
801058e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  // if(x==0){
  //   x=ticks;
  // }
  // x=x*x;
  // x=x+ticks;
  return x;
801058e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801058e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058eb:	c9                   	leave  
801058ec:	c3                   	ret    

801058ed <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801058ed:	55                   	push   %ebp
801058ee:	89 e5                	mov    %esp,%ebp
801058f0:	53                   	push   %ebx
801058f1:	83 ec 04             	sub    $0x4,%esp
801058f4:	e8 2f b4 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801058f9:	05 c7 6b 00 00       	add    $0x6bc7,%eax
  initlock(&lk->lk, "sleep lock");
801058fe:	8b 55 08             	mov    0x8(%ebp),%edx
80105901:	8d 4a 04             	lea    0x4(%edx),%ecx
80105904:	83 ec 08             	sub    $0x8,%esp
80105907:	8d 90 93 d3 ff ff    	lea    -0x2c6d(%eax),%edx
8010590d:	52                   	push   %edx
8010590e:	51                   	push   %ecx
8010590f:	89 c3                	mov    %eax,%ebx
80105911:	e8 c0 01 00 00       	call   80105ad6 <initlock>
80105916:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80105919:	8b 45 08             	mov    0x8(%ebp),%eax
8010591c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010591f:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80105922:	8b 45 08             	mov    0x8(%ebp),%eax
80105925:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
8010592b:	8b 45 08             	mov    0x8(%ebp),%eax
8010592e:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80105935:	90                   	nop
80105936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105939:	c9                   	leave  
8010593a:	c3                   	ret    

8010593b <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
8010593b:	55                   	push   %ebp
8010593c:	89 e5                	mov    %esp,%ebp
8010593e:	53                   	push   %ebx
8010593f:	83 ec 04             	sub    $0x4,%esp
80105942:	e8 3e aa ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105947:	81 c3 79 6b 00 00    	add    $0x6b79,%ebx
  acquire(&lk->lk);
8010594d:	8b 45 08             	mov    0x8(%ebp),%eax
80105950:	83 c0 04             	add    $0x4,%eax
80105953:	83 ec 0c             	sub    $0xc,%esp
80105956:	50                   	push   %eax
80105957:	e8 a6 01 00 00       	call   80105b02 <acquire>
8010595c:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
8010595f:	eb 15                	jmp    80105976 <acquiresleep+0x3b>
    sleep(lk, &lk->lk);
80105961:	8b 45 08             	mov    0x8(%ebp),%eax
80105964:	83 c0 04             	add    $0x4,%eax
80105967:	83 ec 08             	sub    $0x8,%esp
8010596a:	50                   	push   %eax
8010596b:	ff 75 08             	push   0x8(%ebp)
8010596e:	e8 c9 fb ff ff       	call   8010553c <sleep>
80105973:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105976:	8b 45 08             	mov    0x8(%ebp),%eax
80105979:	8b 00                	mov    (%eax),%eax
8010597b:	85 c0                	test   %eax,%eax
8010597d:	75 e2                	jne    80105961 <acquiresleep+0x26>
  }
  lk->locked = 1;
8010597f:	8b 45 08             	mov    0x8(%ebp),%eax
80105982:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = myproc()->pid;
80105988:	e8 19 f2 ff ff       	call   80104ba6 <myproc>
8010598d:	8b 50 10             	mov    0x10(%eax),%edx
80105990:	8b 45 08             	mov    0x8(%ebp),%eax
80105993:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80105996:	8b 45 08             	mov    0x8(%ebp),%eax
80105999:	83 c0 04             	add    $0x4,%eax
8010599c:	83 ec 0c             	sub    $0xc,%esp
8010599f:	50                   	push   %eax
801059a0:	e8 d8 01 00 00       	call   80105b7d <release>
801059a5:	83 c4 10             	add    $0x10,%esp
}
801059a8:	90                   	nop
801059a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059ac:	c9                   	leave  
801059ad:	c3                   	ret    

801059ae <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801059ae:	55                   	push   %ebp
801059af:	89 e5                	mov    %esp,%ebp
801059b1:	53                   	push   %ebx
801059b2:	83 ec 04             	sub    $0x4,%esp
801059b5:	e8 cb a9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801059ba:	81 c3 06 6b 00 00    	add    $0x6b06,%ebx
  acquire(&lk->lk);
801059c0:	8b 45 08             	mov    0x8(%ebp),%eax
801059c3:	83 c0 04             	add    $0x4,%eax
801059c6:	83 ec 0c             	sub    $0xc,%esp
801059c9:	50                   	push   %eax
801059ca:	e8 33 01 00 00       	call   80105b02 <acquire>
801059cf:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
801059d2:	8b 45 08             	mov    0x8(%ebp),%eax
801059d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
801059db:	8b 45 08             	mov    0x8(%ebp),%eax
801059de:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
801059e5:	83 ec 0c             	sub    $0xc,%esp
801059e8:	ff 75 08             	push   0x8(%ebp)
801059eb:	e8 5c fc ff ff       	call   8010564c <wakeup>
801059f0:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
801059f3:	8b 45 08             	mov    0x8(%ebp),%eax
801059f6:	83 c0 04             	add    $0x4,%eax
801059f9:	83 ec 0c             	sub    $0xc,%esp
801059fc:	50                   	push   %eax
801059fd:	e8 7b 01 00 00       	call   80105b7d <release>
80105a02:	83 c4 10             	add    $0x10,%esp
}
80105a05:	90                   	nop
80105a06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a09:	c9                   	leave  
80105a0a:	c3                   	ret    

80105a0b <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105a0b:	55                   	push   %ebp
80105a0c:	89 e5                	mov    %esp,%ebp
80105a0e:	56                   	push   %esi
80105a0f:	53                   	push   %ebx
80105a10:	83 ec 10             	sub    $0x10,%esp
80105a13:	e8 6d a9 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105a18:	81 c3 a8 6a 00 00    	add    $0x6aa8,%ebx
  int r;
  
  acquire(&lk->lk);
80105a1e:	8b 45 08             	mov    0x8(%ebp),%eax
80105a21:	83 c0 04             	add    $0x4,%eax
80105a24:	83 ec 0c             	sub    $0xc,%esp
80105a27:	50                   	push   %eax
80105a28:	e8 d5 00 00 00       	call   80105b02 <acquire>
80105a2d:	83 c4 10             	add    $0x10,%esp
  r = lk->locked && (lk->pid == myproc()->pid);
80105a30:	8b 45 08             	mov    0x8(%ebp),%eax
80105a33:	8b 00                	mov    (%eax),%eax
80105a35:	85 c0                	test   %eax,%eax
80105a37:	74 19                	je     80105a52 <holdingsleep+0x47>
80105a39:	8b 45 08             	mov    0x8(%ebp),%eax
80105a3c:	8b 70 3c             	mov    0x3c(%eax),%esi
80105a3f:	e8 62 f1 ff ff       	call   80104ba6 <myproc>
80105a44:	8b 40 10             	mov    0x10(%eax),%eax
80105a47:	39 c6                	cmp    %eax,%esi
80105a49:	75 07                	jne    80105a52 <holdingsleep+0x47>
80105a4b:	b8 01 00 00 00       	mov    $0x1,%eax
80105a50:	eb 05                	jmp    80105a57 <holdingsleep+0x4c>
80105a52:	b8 00 00 00 00       	mov    $0x0,%eax
80105a57:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80105a5a:	8b 45 08             	mov    0x8(%ebp),%eax
80105a5d:	83 c0 04             	add    $0x4,%eax
80105a60:	83 ec 0c             	sub    $0xc,%esp
80105a63:	50                   	push   %eax
80105a64:	e8 14 01 00 00       	call   80105b7d <release>
80105a69:	83 c4 10             	add    $0x10,%esp
  return r;
80105a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105a6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a72:	5b                   	pop    %ebx
80105a73:	5e                   	pop    %esi
80105a74:	5d                   	pop    %ebp
80105a75:	c3                   	ret    

80105a76 <readeflags>:
{
80105a76:	55                   	push   %ebp
80105a77:	89 e5                	mov    %esp,%ebp
80105a79:	83 ec 10             	sub    $0x10,%esp
80105a7c:	e8 a7 b2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105a81:	05 3f 6a 00 00       	add    $0x6a3f,%eax
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105a86:	9c                   	pushf  
80105a87:	58                   	pop    %eax
80105a88:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80105a8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105a8e:	c9                   	leave  
80105a8f:	c3                   	ret    

80105a90 <cli>:
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	e8 90 b2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105a98:	05 28 6a 00 00       	add    $0x6a28,%eax
  asm volatile("cli");
80105a9d:	fa                   	cli    
}
80105a9e:	90                   	nop
80105a9f:	5d                   	pop    %ebp
80105aa0:	c3                   	ret    

80105aa1 <sti>:
{
80105aa1:	55                   	push   %ebp
80105aa2:	89 e5                	mov    %esp,%ebp
80105aa4:	e8 7f b2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105aa9:	05 17 6a 00 00       	add    $0x6a17,%eax
  asm volatile("sti");
80105aae:	fb                   	sti    
}
80105aaf:	90                   	nop
80105ab0:	5d                   	pop    %ebp
80105ab1:	c3                   	ret    

80105ab2 <xchg>:
{
80105ab2:	55                   	push   %ebp
80105ab3:	89 e5                	mov    %esp,%ebp
80105ab5:	83 ec 10             	sub    $0x10,%esp
80105ab8:	e8 6b b2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105abd:	05 03 6a 00 00       	add    $0x6a03,%eax
  asm volatile("lock; xchgl %0, %1" :
80105ac2:	8b 55 08             	mov    0x8(%ebp),%edx
80105ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ac8:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105acb:	f0 87 02             	lock xchg %eax,(%edx)
80105ace:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80105ad1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105ad4:	c9                   	leave  
80105ad5:	c3                   	ret    

80105ad6 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105ad6:	55                   	push   %ebp
80105ad7:	89 e5                	mov    %esp,%ebp
80105ad9:	e8 4a b2 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105ade:	05 e2 69 00 00       	add    $0x69e2,%eax
  lk->name = name;
80105ae3:	8b 45 08             	mov    0x8(%ebp),%eax
80105ae6:	8b 55 0c             	mov    0xc(%ebp),%edx
80105ae9:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105aec:	8b 45 08             	mov    0x8(%ebp),%eax
80105aef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105af5:	8b 45 08             	mov    0x8(%ebp),%eax
80105af8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105aff:	90                   	nop
80105b00:	5d                   	pop    %ebp
80105b01:	c3                   	ret    

80105b02 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105b02:	55                   	push   %ebp
80105b03:	89 e5                	mov    %esp,%ebp
80105b05:	56                   	push   %esi
80105b06:	53                   	push   %ebx
80105b07:	e8 79 a8 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105b0c:	81 c3 b4 69 00 00    	add    $0x69b4,%ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105b12:	e8 9c 01 00 00       	call   80105cb3 <pushcli>
  if(holding(lk))
80105b17:	8b 45 08             	mov    0x8(%ebp),%eax
80105b1a:	83 ec 0c             	sub    $0xc,%esp
80105b1d:	50                   	push   %eax
80105b1e:	e8 42 01 00 00       	call   80105c65 <holding>
80105b23:	83 c4 10             	add    $0x10,%esp
80105b26:	85 c0                	test   %eax,%eax
80105b28:	74 0f                	je     80105b39 <acquire+0x37>
    panic("acquire");
80105b2a:	83 ec 0c             	sub    $0xc,%esp
80105b2d:	8d 83 9e d3 ff ff    	lea    -0x2c62(%ebx),%eax
80105b33:	50                   	push   %eax
80105b34:	e8 3c ab ff ff       	call   80100675 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105b39:	90                   	nop
80105b3a:	8b 45 08             	mov    0x8(%ebp),%eax
80105b3d:	83 ec 08             	sub    $0x8,%esp
80105b40:	6a 01                	push   $0x1
80105b42:	50                   	push   %eax
80105b43:	e8 6a ff ff ff       	call   80105ab2 <xchg>
80105b48:	83 c4 10             	add    $0x10,%esp
80105b4b:	85 c0                	test   %eax,%eax
80105b4d:	75 eb                	jne    80105b3a <acquire+0x38>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80105b4f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105b54:	8b 75 08             	mov    0x8(%ebp),%esi
80105b57:	e8 b6 ef ff ff       	call   80104b12 <mycpu>
80105b5c:	89 46 08             	mov    %eax,0x8(%esi)
  getcallerpcs(&lk, lk->pcs);
80105b5f:	8b 45 08             	mov    0x8(%ebp),%eax
80105b62:	83 c0 0c             	add    $0xc,%eax
80105b65:	83 ec 08             	sub    $0x8,%esp
80105b68:	50                   	push   %eax
80105b69:	8d 45 08             	lea    0x8(%ebp),%eax
80105b6c:	50                   	push   %eax
80105b6d:	e8 6e 00 00 00       	call   80105be0 <getcallerpcs>
80105b72:	83 c4 10             	add    $0x10,%esp
}
80105b75:	90                   	nop
80105b76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b79:	5b                   	pop    %ebx
80105b7a:	5e                   	pop    %esi
80105b7b:	5d                   	pop    %ebp
80105b7c:	c3                   	ret    

80105b7d <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105b7d:	55                   	push   %ebp
80105b7e:	89 e5                	mov    %esp,%ebp
80105b80:	53                   	push   %ebx
80105b81:	83 ec 04             	sub    $0x4,%esp
80105b84:	e8 fc a7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105b89:	81 c3 37 69 00 00    	add    $0x6937,%ebx
  if(!holding(lk))
80105b8f:	83 ec 0c             	sub    $0xc,%esp
80105b92:	ff 75 08             	push   0x8(%ebp)
80105b95:	e8 cb 00 00 00       	call   80105c65 <holding>
80105b9a:	83 c4 10             	add    $0x10,%esp
80105b9d:	85 c0                	test   %eax,%eax
80105b9f:	75 0f                	jne    80105bb0 <release+0x33>
    panic("release");
80105ba1:	83 ec 0c             	sub    $0xc,%esp
80105ba4:	8d 83 a6 d3 ff ff    	lea    -0x2c5a(%ebx),%eax
80105baa:	50                   	push   %eax
80105bab:	e8 c5 aa ff ff       	call   80100675 <panic>

  lk->pcs[0] = 0;
80105bb0:	8b 45 08             	mov    0x8(%ebp),%eax
80105bb3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105bba:	8b 45 08             	mov    0x8(%ebp),%eax
80105bbd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105bc4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80105bcc:	8b 55 08             	mov    0x8(%ebp),%edx
80105bcf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
80105bd5:	e8 35 01 00 00       	call   80105d0f <popcli>
}
80105bda:	90                   	nop
80105bdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bde:	c9                   	leave  
80105bdf:	c3                   	ret    

80105be0 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 10             	sub    $0x10,%esp
80105be6:	e8 3d b1 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105beb:	05 d5 68 00 00       	add    $0x68d5,%eax
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80105bf3:	83 e8 08             	sub    $0x8,%eax
80105bf6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105bf9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105c00:	eb 38                	jmp    80105c3a <getcallerpcs+0x5a>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105c02:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80105c06:	74 53                	je     80105c5b <getcallerpcs+0x7b>
80105c08:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105c0f:	76 4a                	jbe    80105c5b <getcallerpcs+0x7b>
80105c11:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105c15:	74 44                	je     80105c5b <getcallerpcs+0x7b>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105c17:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105c1a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105c21:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c24:	01 c2                	add    %eax,%edx
80105c26:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105c29:	8b 40 04             	mov    0x4(%eax),%eax
80105c2c:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105c2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105c31:	8b 00                	mov    (%eax),%eax
80105c33:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80105c36:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105c3a:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105c3e:	7e c2                	jle    80105c02 <getcallerpcs+0x22>
  }
  for(; i < 10; i++)
80105c40:	eb 19                	jmp    80105c5b <getcallerpcs+0x7b>
    pcs[i] = 0;
80105c42:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105c45:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105c4f:	01 d0                	add    %edx,%eax
80105c51:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105c57:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105c5b:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105c5f:	7e e1                	jle    80105c42 <getcallerpcs+0x62>
}
80105c61:	90                   	nop
80105c62:	90                   	nop
80105c63:	c9                   	leave  
80105c64:	c3                   	ret    

80105c65 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105c65:	55                   	push   %ebp
80105c66:	89 e5                	mov    %esp,%ebp
80105c68:	56                   	push   %esi
80105c69:	53                   	push   %ebx
80105c6a:	83 ec 10             	sub    $0x10,%esp
80105c6d:	e8 13 a7 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105c72:	81 c3 4e 68 00 00    	add    $0x684e,%ebx
  int r;
  pushcli();
80105c78:	e8 36 00 00 00       	call   80105cb3 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105c7d:	8b 45 08             	mov    0x8(%ebp),%eax
80105c80:	8b 00                	mov    (%eax),%eax
80105c82:	85 c0                	test   %eax,%eax
80105c84:	74 16                	je     80105c9c <holding+0x37>
80105c86:	8b 45 08             	mov    0x8(%ebp),%eax
80105c89:	8b 70 08             	mov    0x8(%eax),%esi
80105c8c:	e8 81 ee ff ff       	call   80104b12 <mycpu>
80105c91:	39 c6                	cmp    %eax,%esi
80105c93:	75 07                	jne    80105c9c <holding+0x37>
80105c95:	b8 01 00 00 00       	mov    $0x1,%eax
80105c9a:	eb 05                	jmp    80105ca1 <holding+0x3c>
80105c9c:	b8 00 00 00 00       	mov    $0x0,%eax
80105ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
80105ca4:	e8 66 00 00 00       	call   80105d0f <popcli>
  return r;
80105ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	5b                   	pop    %ebx
80105cb0:	5e                   	pop    %esi
80105cb1:	5d                   	pop    %ebp
80105cb2:	c3                   	ret    

80105cb3 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105cb3:	55                   	push   %ebp
80105cb4:	89 e5                	mov    %esp,%ebp
80105cb6:	53                   	push   %ebx
80105cb7:	83 ec 14             	sub    $0x14,%esp
80105cba:	e8 c6 a6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105cbf:	81 c3 01 68 00 00    	add    $0x6801,%ebx
  int eflags;

  eflags = readeflags();
80105cc5:	e8 ac fd ff ff       	call   80105a76 <readeflags>
80105cca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
80105ccd:	e8 be fd ff ff       	call   80105a90 <cli>
  if(mycpu()->ncli == 0)
80105cd2:	e8 3b ee ff ff       	call   80104b12 <mycpu>
80105cd7:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105cdd:	85 c0                	test   %eax,%eax
80105cdf:	75 14                	jne    80105cf5 <pushcli+0x42>
    mycpu()->intena = eflags & FL_IF;
80105ce1:	e8 2c ee ff ff       	call   80104b12 <mycpu>
80105ce6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ce9:	81 e2 00 02 00 00    	and    $0x200,%edx
80105cef:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
  mycpu()->ncli += 1;
80105cf5:	e8 18 ee ff ff       	call   80104b12 <mycpu>
80105cfa:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105d00:	83 c2 01             	add    $0x1,%edx
80105d03:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
80105d09:	90                   	nop
80105d0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d0d:	c9                   	leave  
80105d0e:	c3                   	ret    

80105d0f <popcli>:

void
popcli(void)
{
80105d0f:	55                   	push   %ebp
80105d10:	89 e5                	mov    %esp,%ebp
80105d12:	53                   	push   %ebx
80105d13:	83 ec 04             	sub    $0x4,%esp
80105d16:	e8 6a a6 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80105d1b:	81 c3 a5 67 00 00    	add    $0x67a5,%ebx
  if(readeflags()&FL_IF)
80105d21:	e8 50 fd ff ff       	call   80105a76 <readeflags>
80105d26:	25 00 02 00 00       	and    $0x200,%eax
80105d2b:	85 c0                	test   %eax,%eax
80105d2d:	74 0f                	je     80105d3e <popcli+0x2f>
    panic("popcli - interruptible");
80105d2f:	83 ec 0c             	sub    $0xc,%esp
80105d32:	8d 83 ae d3 ff ff    	lea    -0x2c52(%ebx),%eax
80105d38:	50                   	push   %eax
80105d39:	e8 37 a9 ff ff       	call   80100675 <panic>
  if(--mycpu()->ncli < 0)
80105d3e:	e8 cf ed ff ff       	call   80104b12 <mycpu>
80105d43:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105d49:	83 ea 01             	sub    $0x1,%edx
80105d4c:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80105d52:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105d58:	85 c0                	test   %eax,%eax
80105d5a:	79 0f                	jns    80105d6b <popcli+0x5c>
    panic("popcli");
80105d5c:	83 ec 0c             	sub    $0xc,%esp
80105d5f:	8d 83 c5 d3 ff ff    	lea    -0x2c3b(%ebx),%eax
80105d65:	50                   	push   %eax
80105d66:	e8 0a a9 ff ff       	call   80100675 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105d6b:	e8 a2 ed ff ff       	call   80104b12 <mycpu>
80105d70:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105d76:	85 c0                	test   %eax,%eax
80105d78:	75 14                	jne    80105d8e <popcli+0x7f>
80105d7a:	e8 93 ed ff ff       	call   80104b12 <mycpu>
80105d7f:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80105d85:	85 c0                	test   %eax,%eax
80105d87:	74 05                	je     80105d8e <popcli+0x7f>
    sti();
80105d89:	e8 13 fd ff ff       	call   80105aa1 <sti>
}
80105d8e:	90                   	nop
80105d8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d92:	c9                   	leave  
80105d93:	c3                   	ret    

80105d94 <stosb>:
{
80105d94:	55                   	push   %ebp
80105d95:	89 e5                	mov    %esp,%ebp
80105d97:	57                   	push   %edi
80105d98:	53                   	push   %ebx
80105d99:	e8 8a af ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105d9e:	05 22 67 00 00       	add    $0x6722,%eax
  asm volatile("cld; rep stosb" :
80105da3:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105da6:	8b 55 10             	mov    0x10(%ebp),%edx
80105da9:	8b 45 0c             	mov    0xc(%ebp),%eax
80105dac:	89 cb                	mov    %ecx,%ebx
80105dae:	89 df                	mov    %ebx,%edi
80105db0:	89 d1                	mov    %edx,%ecx
80105db2:	fc                   	cld    
80105db3:	f3 aa                	rep stos %al,%es:(%edi)
80105db5:	89 ca                	mov    %ecx,%edx
80105db7:	89 fb                	mov    %edi,%ebx
80105db9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105dbc:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105dbf:	90                   	nop
80105dc0:	5b                   	pop    %ebx
80105dc1:	5f                   	pop    %edi
80105dc2:	5d                   	pop    %ebp
80105dc3:	c3                   	ret    

80105dc4 <stosl>:
{
80105dc4:	55                   	push   %ebp
80105dc5:	89 e5                	mov    %esp,%ebp
80105dc7:	57                   	push   %edi
80105dc8:	53                   	push   %ebx
80105dc9:	e8 5a af ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105dce:	05 f2 66 00 00       	add    $0x66f2,%eax
  asm volatile("cld; rep stosl" :
80105dd3:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105dd6:	8b 55 10             	mov    0x10(%ebp),%edx
80105dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ddc:	89 cb                	mov    %ecx,%ebx
80105dde:	89 df                	mov    %ebx,%edi
80105de0:	89 d1                	mov    %edx,%ecx
80105de2:	fc                   	cld    
80105de3:	f3 ab                	rep stos %eax,%es:(%edi)
80105de5:	89 ca                	mov    %ecx,%edx
80105de7:	89 fb                	mov    %edi,%ebx
80105de9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105dec:	89 55 10             	mov    %edx,0x10(%ebp)
}
80105def:	90                   	nop
80105df0:	5b                   	pop    %ebx
80105df1:	5f                   	pop    %edi
80105df2:	5d                   	pop    %ebp
80105df3:	c3                   	ret    

80105df4 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105df4:	55                   	push   %ebp
80105df5:	89 e5                	mov    %esp,%ebp
80105df7:	e8 2c af ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105dfc:	05 c4 66 00 00       	add    $0x66c4,%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80105e01:	8b 45 08             	mov    0x8(%ebp),%eax
80105e04:	83 e0 03             	and    $0x3,%eax
80105e07:	85 c0                	test   %eax,%eax
80105e09:	75 43                	jne    80105e4e <memset+0x5a>
80105e0b:	8b 45 10             	mov    0x10(%ebp),%eax
80105e0e:	83 e0 03             	and    $0x3,%eax
80105e11:	85 c0                	test   %eax,%eax
80105e13:	75 39                	jne    80105e4e <memset+0x5a>
    c &= 0xFF;
80105e15:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105e1c:	8b 45 10             	mov    0x10(%ebp),%eax
80105e1f:	c1 e8 02             	shr    $0x2,%eax
80105e22:	89 c2                	mov    %eax,%edx
80105e24:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e27:	c1 e0 18             	shl    $0x18,%eax
80105e2a:	89 c1                	mov    %eax,%ecx
80105e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e2f:	c1 e0 10             	shl    $0x10,%eax
80105e32:	09 c1                	or     %eax,%ecx
80105e34:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e37:	c1 e0 08             	shl    $0x8,%eax
80105e3a:	09 c8                	or     %ecx,%eax
80105e3c:	0b 45 0c             	or     0xc(%ebp),%eax
80105e3f:	52                   	push   %edx
80105e40:	50                   	push   %eax
80105e41:	ff 75 08             	push   0x8(%ebp)
80105e44:	e8 7b ff ff ff       	call   80105dc4 <stosl>
80105e49:	83 c4 0c             	add    $0xc,%esp
80105e4c:	eb 12                	jmp    80105e60 <memset+0x6c>
  } else
    stosb(dst, c, n);
80105e4e:	8b 45 10             	mov    0x10(%ebp),%eax
80105e51:	50                   	push   %eax
80105e52:	ff 75 0c             	push   0xc(%ebp)
80105e55:	ff 75 08             	push   0x8(%ebp)
80105e58:	e8 37 ff ff ff       	call   80105d94 <stosb>
80105e5d:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105e60:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105e63:	c9                   	leave  
80105e64:	c3                   	ret    

80105e65 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105e65:	55                   	push   %ebp
80105e66:	89 e5                	mov    %esp,%ebp
80105e68:	83 ec 10             	sub    $0x10,%esp
80105e6b:	e8 b8 ae ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105e70:	05 50 66 00 00       	add    $0x6650,%eax
  const uchar *s1, *s2;

  s1 = v1;
80105e75:	8b 45 08             	mov    0x8(%ebp),%eax
80105e78:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105e81:	eb 30                	jmp    80105eb3 <memcmp+0x4e>
    if(*s1 != *s2)
80105e83:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105e86:	0f b6 10             	movzbl (%eax),%edx
80105e89:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105e8c:	0f b6 00             	movzbl (%eax),%eax
80105e8f:	38 c2                	cmp    %al,%dl
80105e91:	74 18                	je     80105eab <memcmp+0x46>
      return *s1 - *s2;
80105e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105e96:	0f b6 00             	movzbl (%eax),%eax
80105e99:	0f b6 d0             	movzbl %al,%edx
80105e9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105e9f:	0f b6 00             	movzbl (%eax),%eax
80105ea2:	0f b6 c8             	movzbl %al,%ecx
80105ea5:	89 d0                	mov    %edx,%eax
80105ea7:	29 c8                	sub    %ecx,%eax
80105ea9:	eb 1a                	jmp    80105ec5 <memcmp+0x60>
    s1++, s2++;
80105eab:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105eaf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
80105eb3:	8b 45 10             	mov    0x10(%ebp),%eax
80105eb6:	8d 50 ff             	lea    -0x1(%eax),%edx
80105eb9:	89 55 10             	mov    %edx,0x10(%ebp)
80105ebc:	85 c0                	test   %eax,%eax
80105ebe:	75 c3                	jne    80105e83 <memcmp+0x1e>
  }

  return 0;
80105ec0:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ec5:	c9                   	leave  
80105ec6:	c3                   	ret    

80105ec7 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105ec7:	55                   	push   %ebp
80105ec8:	89 e5                	mov    %esp,%ebp
80105eca:	83 ec 10             	sub    $0x10,%esp
80105ecd:	e8 56 ae ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105ed2:	05 ee 65 00 00       	add    $0x65ee,%eax
  const char *s;
  char *d;

  s = src;
80105ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
80105eda:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105edd:	8b 45 08             	mov    0x8(%ebp),%eax
80105ee0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105ee3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105ee6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105ee9:	73 54                	jae    80105f3f <memmove+0x78>
80105eeb:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105eee:	8b 45 10             	mov    0x10(%ebp),%eax
80105ef1:	01 d0                	add    %edx,%eax
80105ef3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80105ef6:	73 47                	jae    80105f3f <memmove+0x78>
    s += n;
80105ef8:	8b 45 10             	mov    0x10(%ebp),%eax
80105efb:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105efe:	8b 45 10             	mov    0x10(%ebp),%eax
80105f01:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105f04:	eb 13                	jmp    80105f19 <memmove+0x52>
      *--d = *--s;
80105f06:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105f0a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105f0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105f11:	0f b6 10             	movzbl (%eax),%edx
80105f14:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105f17:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105f19:	8b 45 10             	mov    0x10(%ebp),%eax
80105f1c:	8d 50 ff             	lea    -0x1(%eax),%edx
80105f1f:	89 55 10             	mov    %edx,0x10(%ebp)
80105f22:	85 c0                	test   %eax,%eax
80105f24:	75 e0                	jne    80105f06 <memmove+0x3f>
  if(s < d && s + n > d){
80105f26:	eb 24                	jmp    80105f4c <memmove+0x85>
  } else
    while(n-- > 0)
      *d++ = *s++;
80105f28:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105f2b:	8d 42 01             	lea    0x1(%edx),%eax
80105f2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105f31:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105f34:	8d 48 01             	lea    0x1(%eax),%ecx
80105f37:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80105f3a:	0f b6 12             	movzbl (%edx),%edx
80105f3d:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80105f3f:	8b 45 10             	mov    0x10(%ebp),%eax
80105f42:	8d 50 ff             	lea    -0x1(%eax),%edx
80105f45:	89 55 10             	mov    %edx,0x10(%ebp)
80105f48:	85 c0                	test   %eax,%eax
80105f4a:	75 dc                	jne    80105f28 <memmove+0x61>

  return dst;
80105f4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105f4f:	c9                   	leave  
80105f50:	c3                   	ret    

80105f51 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105f51:	55                   	push   %ebp
80105f52:	89 e5                	mov    %esp,%ebp
80105f54:	e8 cf ad ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105f59:	05 67 65 00 00       	add    $0x6567,%eax
  return memmove(dst, src, n);
80105f5e:	ff 75 10             	push   0x10(%ebp)
80105f61:	ff 75 0c             	push   0xc(%ebp)
80105f64:	ff 75 08             	push   0x8(%ebp)
80105f67:	e8 5b ff ff ff       	call   80105ec7 <memmove>
80105f6c:	83 c4 0c             	add    $0xc,%esp
}
80105f6f:	c9                   	leave  
80105f70:	c3                   	ret    

80105f71 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105f71:	55                   	push   %ebp
80105f72:	89 e5                	mov    %esp,%ebp
80105f74:	e8 af ad ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105f79:	05 47 65 00 00       	add    $0x6547,%eax
  while(n > 0 && *p && *p == *q)
80105f7e:	eb 0c                	jmp    80105f8c <strncmp+0x1b>
    n--, p++, q++;
80105f80:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105f84:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105f88:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80105f8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105f90:	74 1a                	je     80105fac <strncmp+0x3b>
80105f92:	8b 45 08             	mov    0x8(%ebp),%eax
80105f95:	0f b6 00             	movzbl (%eax),%eax
80105f98:	84 c0                	test   %al,%al
80105f9a:	74 10                	je     80105fac <strncmp+0x3b>
80105f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80105f9f:	0f b6 10             	movzbl (%eax),%edx
80105fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fa5:	0f b6 00             	movzbl (%eax),%eax
80105fa8:	38 c2                	cmp    %al,%dl
80105faa:	74 d4                	je     80105f80 <strncmp+0xf>
  if(n == 0)
80105fac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105fb0:	75 07                	jne    80105fb9 <strncmp+0x48>
    return 0;
80105fb2:	b8 00 00 00 00       	mov    $0x0,%eax
80105fb7:	eb 16                	jmp    80105fcf <strncmp+0x5e>
  return (uchar)*p - (uchar)*q;
80105fb9:	8b 45 08             	mov    0x8(%ebp),%eax
80105fbc:	0f b6 00             	movzbl (%eax),%eax
80105fbf:	0f b6 d0             	movzbl %al,%edx
80105fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
80105fc5:	0f b6 00             	movzbl (%eax),%eax
80105fc8:	0f b6 c8             	movzbl %al,%ecx
80105fcb:	89 d0                	mov    %edx,%eax
80105fcd:	29 c8                	sub    %ecx,%eax
}
80105fcf:	5d                   	pop    %ebp
80105fd0:	c3                   	ret    

80105fd1 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105fd1:	55                   	push   %ebp
80105fd2:	89 e5                	mov    %esp,%ebp
80105fd4:	83 ec 10             	sub    $0x10,%esp
80105fd7:	e8 4c ad ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80105fdc:	05 e4 64 00 00       	add    $0x64e4,%eax
  char *os;

  os = s;
80105fe1:	8b 45 08             	mov    0x8(%ebp),%eax
80105fe4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105fe7:	90                   	nop
80105fe8:	8b 45 10             	mov    0x10(%ebp),%eax
80105feb:	8d 50 ff             	lea    -0x1(%eax),%edx
80105fee:	89 55 10             	mov    %edx,0x10(%ebp)
80105ff1:	85 c0                	test   %eax,%eax
80105ff3:	7e 2c                	jle    80106021 <strncpy+0x50>
80105ff5:	8b 55 0c             	mov    0xc(%ebp),%edx
80105ff8:	8d 42 01             	lea    0x1(%edx),%eax
80105ffb:	89 45 0c             	mov    %eax,0xc(%ebp)
80105ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80106001:	8d 48 01             	lea    0x1(%eax),%ecx
80106004:	89 4d 08             	mov    %ecx,0x8(%ebp)
80106007:	0f b6 12             	movzbl (%edx),%edx
8010600a:	88 10                	mov    %dl,(%eax)
8010600c:	0f b6 00             	movzbl (%eax),%eax
8010600f:	84 c0                	test   %al,%al
80106011:	75 d5                	jne    80105fe8 <strncpy+0x17>
    ;
  while(n-- > 0)
80106013:	eb 0c                	jmp    80106021 <strncpy+0x50>
    *s++ = 0;
80106015:	8b 45 08             	mov    0x8(%ebp),%eax
80106018:	8d 50 01             	lea    0x1(%eax),%edx
8010601b:	89 55 08             	mov    %edx,0x8(%ebp)
8010601e:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80106021:	8b 45 10             	mov    0x10(%ebp),%eax
80106024:	8d 50 ff             	lea    -0x1(%eax),%edx
80106027:	89 55 10             	mov    %edx,0x10(%ebp)
8010602a:	85 c0                	test   %eax,%eax
8010602c:	7f e7                	jg     80106015 <strncpy+0x44>
  return os;
8010602e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106031:	c9                   	leave  
80106032:	c3                   	ret    

80106033 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106033:	55                   	push   %ebp
80106034:	89 e5                	mov    %esp,%ebp
80106036:	83 ec 10             	sub    $0x10,%esp
80106039:	e8 ea ac ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010603e:	05 82 64 00 00       	add    $0x6482,%eax
  char *os;

  os = s;
80106043:	8b 45 08             	mov    0x8(%ebp),%eax
80106046:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80106049:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010604d:	7f 05                	jg     80106054 <safestrcpy+0x21>
    return os;
8010604f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106052:	eb 32                	jmp    80106086 <safestrcpy+0x53>
  while(--n > 0 && (*s++ = *t++) != 0)
80106054:	90                   	nop
80106055:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106059:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010605d:	7e 1e                	jle    8010607d <safestrcpy+0x4a>
8010605f:	8b 55 0c             	mov    0xc(%ebp),%edx
80106062:	8d 42 01             	lea    0x1(%edx),%eax
80106065:	89 45 0c             	mov    %eax,0xc(%ebp)
80106068:	8b 45 08             	mov    0x8(%ebp),%eax
8010606b:	8d 48 01             	lea    0x1(%eax),%ecx
8010606e:	89 4d 08             	mov    %ecx,0x8(%ebp)
80106071:	0f b6 12             	movzbl (%edx),%edx
80106074:	88 10                	mov    %dl,(%eax)
80106076:	0f b6 00             	movzbl (%eax),%eax
80106079:	84 c0                	test   %al,%al
8010607b:	75 d8                	jne    80106055 <safestrcpy+0x22>
    ;
  *s = 0;
8010607d:	8b 45 08             	mov    0x8(%ebp),%eax
80106080:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80106083:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106086:	c9                   	leave  
80106087:	c3                   	ret    

80106088 <strlen>:

int
strlen(const char *s)
{
80106088:	55                   	push   %ebp
80106089:	89 e5                	mov    %esp,%ebp
8010608b:	83 ec 10             	sub    $0x10,%esp
8010608e:	e8 95 ac ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80106093:	05 2d 64 00 00       	add    $0x642d,%eax
  int n;

  for(n = 0; s[n]; n++)
80106098:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010609f:	eb 04                	jmp    801060a5 <strlen+0x1d>
801060a1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801060a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
801060a8:	8b 45 08             	mov    0x8(%ebp),%eax
801060ab:	01 d0                	add    %edx,%eax
801060ad:	0f b6 00             	movzbl (%eax),%eax
801060b0:	84 c0                	test   %al,%al
801060b2:	75 ed                	jne    801060a1 <strlen+0x19>
    ;
  return n;
801060b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801060b7:	c9                   	leave  
801060b8:	c3                   	ret    

801060b9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801060b9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801060bd:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801060c1:	55                   	push   %ebp
  pushl %ebx
801060c2:	53                   	push   %ebx
  pushl %esi
801060c3:	56                   	push   %esi
  pushl %edi
801060c4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801060c5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801060c7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801060c9:	5f                   	pop    %edi
  popl %esi
801060ca:	5e                   	pop    %esi
  popl %ebx
801060cb:	5b                   	pop    %ebx
  popl %ebp
801060cc:	5d                   	pop    %ebp
  ret
801060cd:	c3                   	ret    

801060ce <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801060ce:	55                   	push   %ebp
801060cf:	89 e5                	mov    %esp,%ebp
801060d1:	53                   	push   %ebx
801060d2:	83 ec 14             	sub    $0x14,%esp
801060d5:	e8 4e ac ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801060da:	05 e6 63 00 00       	add    $0x63e6,%eax
  struct proc *curproc = myproc();
801060df:	89 c3                	mov    %eax,%ebx
801060e1:	e8 c0 ea ff ff       	call   80104ba6 <myproc>
801060e6:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801060e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ec:	8b 00                	mov    (%eax),%eax
801060ee:	39 45 08             	cmp    %eax,0x8(%ebp)
801060f1:	73 0f                	jae    80106102 <fetchint+0x34>
801060f3:	8b 45 08             	mov    0x8(%ebp),%eax
801060f6:	8d 50 04             	lea    0x4(%eax),%edx
801060f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060fc:	8b 00                	mov    (%eax),%eax
801060fe:	39 c2                	cmp    %eax,%edx
80106100:	76 07                	jbe    80106109 <fetchint+0x3b>
    return -1;
80106102:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106107:	eb 0f                	jmp    80106118 <fetchint+0x4a>
  *ip = *(int*)(addr);
80106109:	8b 45 08             	mov    0x8(%ebp),%eax
8010610c:	8b 10                	mov    (%eax),%edx
8010610e:	8b 45 0c             	mov    0xc(%ebp),%eax
80106111:	89 10                	mov    %edx,(%eax)
  return 0;
80106113:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106118:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010611b:	c9                   	leave  
8010611c:	c3                   	ret    

8010611d <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010611d:	55                   	push   %ebp
8010611e:	89 e5                	mov    %esp,%ebp
80106120:	53                   	push   %ebx
80106121:	83 ec 14             	sub    $0x14,%esp
80106124:	e8 ff ab ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80106129:	05 97 63 00 00       	add    $0x6397,%eax
  char *s, *ep;
  struct proc *curproc = myproc();
8010612e:	89 c3                	mov    %eax,%ebx
80106130:	e8 71 ea ff ff       	call   80104ba6 <myproc>
80106135:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(addr >= curproc->sz)
80106138:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010613b:	8b 00                	mov    (%eax),%eax
8010613d:	39 45 08             	cmp    %eax,0x8(%ebp)
80106140:	72 07                	jb     80106149 <fetchstr+0x2c>
    return -1;
80106142:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106147:	eb 41                	jmp    8010618a <fetchstr+0x6d>
  *pp = (char*)addr;
80106149:	8b 55 08             	mov    0x8(%ebp),%edx
8010614c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010614f:	89 10                	mov    %edx,(%eax)
  ep = (char*)curproc->sz;
80106151:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106154:	8b 00                	mov    (%eax),%eax
80106156:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(s = *pp; s < ep; s++){
80106159:	8b 45 0c             	mov    0xc(%ebp),%eax
8010615c:	8b 00                	mov    (%eax),%eax
8010615e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106161:	eb 1a                	jmp    8010617d <fetchstr+0x60>
    if(*s == 0)
80106163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106166:	0f b6 00             	movzbl (%eax),%eax
80106169:	84 c0                	test   %al,%al
8010616b:	75 0c                	jne    80106179 <fetchstr+0x5c>
      return s - *pp;
8010616d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106170:	8b 10                	mov    (%eax),%edx
80106172:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106175:	29 d0                	sub    %edx,%eax
80106177:	eb 11                	jmp    8010618a <fetchstr+0x6d>
  for(s = *pp; s < ep; s++){
80106179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010617d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106180:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80106183:	72 de                	jb     80106163 <fetchstr+0x46>
  }
  return -1;
80106185:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010618a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010618d:	c9                   	leave  
8010618e:	c3                   	ret    

8010618f <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010618f:	55                   	push   %ebp
80106190:	89 e5                	mov    %esp,%ebp
80106192:	53                   	push   %ebx
80106193:	83 ec 04             	sub    $0x4,%esp
80106196:	e8 8d ab ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010619b:	05 25 63 00 00       	add    $0x6325,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801061a0:	89 c3                	mov    %eax,%ebx
801061a2:	e8 ff e9 ff ff       	call   80104ba6 <myproc>
801061a7:	8b 40 18             	mov    0x18(%eax),%eax
801061aa:	8b 50 44             	mov    0x44(%eax),%edx
801061ad:	8b 45 08             	mov    0x8(%ebp),%eax
801061b0:	c1 e0 02             	shl    $0x2,%eax
801061b3:	01 d0                	add    %edx,%eax
801061b5:	83 c0 04             	add    $0x4,%eax
801061b8:	83 ec 08             	sub    $0x8,%esp
801061bb:	ff 75 0c             	push   0xc(%ebp)
801061be:	50                   	push   %eax
801061bf:	e8 0a ff ff ff       	call   801060ce <fetchint>
801061c4:	83 c4 10             	add    $0x10,%esp
}
801061c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061ca:	c9                   	leave  
801061cb:	c3                   	ret    

801061cc <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801061cc:	55                   	push   %ebp
801061cd:	89 e5                	mov    %esp,%ebp
801061cf:	53                   	push   %ebx
801061d0:	83 ec 14             	sub    $0x14,%esp
801061d3:	e8 50 ab ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801061d8:	05 e8 62 00 00       	add    $0x62e8,%eax
  int i;
  struct proc *curproc = myproc();
801061dd:	89 c3                	mov    %eax,%ebx
801061df:	e8 c2 e9 ff ff       	call   80104ba6 <myproc>
801061e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 
  if(argint(n, &i) < 0)
801061e7:	83 ec 08             	sub    $0x8,%esp
801061ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061ed:	50                   	push   %eax
801061ee:	ff 75 08             	push   0x8(%ebp)
801061f1:	e8 99 ff ff ff       	call   8010618f <argint>
801061f6:	83 c4 10             	add    $0x10,%esp
801061f9:	85 c0                	test   %eax,%eax
801061fb:	79 07                	jns    80106204 <argptr+0x38>
    return -1;
801061fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106202:	eb 3b                	jmp    8010623f <argptr+0x73>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106204:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106208:	78 1f                	js     80106229 <argptr+0x5d>
8010620a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010620d:	8b 00                	mov    (%eax),%eax
8010620f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106212:	39 d0                	cmp    %edx,%eax
80106214:	76 13                	jbe    80106229 <argptr+0x5d>
80106216:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106219:	89 c2                	mov    %eax,%edx
8010621b:	8b 45 10             	mov    0x10(%ebp),%eax
8010621e:	01 c2                	add    %eax,%edx
80106220:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106223:	8b 00                	mov    (%eax),%eax
80106225:	39 c2                	cmp    %eax,%edx
80106227:	76 07                	jbe    80106230 <argptr+0x64>
    return -1;
80106229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010622e:	eb 0f                	jmp    8010623f <argptr+0x73>
  *pp = (char*)i;
80106230:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106233:	89 c2                	mov    %eax,%edx
80106235:	8b 45 0c             	mov    0xc(%ebp),%eax
80106238:	89 10                	mov    %edx,(%eax)
  return 0;
8010623a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010623f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106242:	c9                   	leave  
80106243:	c3                   	ret    

80106244 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106244:	55                   	push   %ebp
80106245:	89 e5                	mov    %esp,%ebp
80106247:	83 ec 18             	sub    $0x18,%esp
8010624a:	e8 d9 aa ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010624f:	05 71 62 00 00       	add    $0x6271,%eax
  int addr;
  if(argint(n, &addr) < 0)
80106254:	83 ec 08             	sub    $0x8,%esp
80106257:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010625a:	50                   	push   %eax
8010625b:	ff 75 08             	push   0x8(%ebp)
8010625e:	e8 2c ff ff ff       	call   8010618f <argint>
80106263:	83 c4 10             	add    $0x10,%esp
80106266:	85 c0                	test   %eax,%eax
80106268:	79 07                	jns    80106271 <argstr+0x2d>
    return -1;
8010626a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010626f:	eb 12                	jmp    80106283 <argstr+0x3f>
  return fetchstr(addr, pp);
80106271:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106274:	83 ec 08             	sub    $0x8,%esp
80106277:	ff 75 0c             	push   0xc(%ebp)
8010627a:	50                   	push   %eax
8010627b:	e8 9d fe ff ff       	call   8010611d <fetchstr>
80106280:	83 c4 10             	add    $0x10,%esp
}
80106283:	c9                   	leave  
80106284:	c3                   	ret    

80106285 <syscall>:
[SYS_random]  sys_random,
};

void
syscall(void)
{
80106285:	55                   	push   %ebp
80106286:	89 e5                	mov    %esp,%ebp
80106288:	53                   	push   %ebx
80106289:	83 ec 14             	sub    $0x14,%esp
8010628c:	e8 f4 a0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106291:	81 c3 2f 62 00 00    	add    $0x622f,%ebx
  int num;
  struct proc *curproc = myproc();
80106297:	e8 0a e9 ff ff       	call   80104ba6 <myproc>
8010629c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  num = curproc->tf->eax;
8010629f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a2:	8b 40 18             	mov    0x18(%eax),%eax
801062a5:	8b 40 1c             	mov    0x1c(%eax),%eax
801062a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801062ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801062af:	7e 2f                	jle    801062e0 <syscall+0x5b>
801062b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062b4:	83 f8 16             	cmp    $0x16,%eax
801062b7:	77 27                	ja     801062e0 <syscall+0x5b>
801062b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062bc:	8b 84 83 40 00 00 00 	mov    0x40(%ebx,%eax,4),%eax
801062c3:	85 c0                	test   %eax,%eax
801062c5:	74 19                	je     801062e0 <syscall+0x5b>
    curproc->tf->eax = syscalls[num]();
801062c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ca:	8b 84 83 40 00 00 00 	mov    0x40(%ebx,%eax,4),%eax
801062d1:	ff d0                	call   *%eax
801062d3:	89 c2                	mov    %eax,%edx
801062d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d8:	8b 40 18             	mov    0x18(%eax),%eax
801062db:	89 50 1c             	mov    %edx,0x1c(%eax)
801062de:	eb 2e                	jmp    8010630e <syscall+0x89>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
801062e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e3:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%d %s: unknown sys call %d\n",
801062e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e9:	8b 40 10             	mov    0x10(%eax),%eax
801062ec:	ff 75 f0             	push   -0x10(%ebp)
801062ef:	52                   	push   %edx
801062f0:	50                   	push   %eax
801062f1:	8d 83 cc d3 ff ff    	lea    -0x2c34(%ebx),%eax
801062f7:	50                   	push   %eax
801062f8:	e8 ab a1 ff ff       	call   801004a8 <cprintf>
801062fd:	83 c4 10             	add    $0x10,%esp
    curproc->tf->eax = -1;
80106300:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106303:	8b 40 18             	mov    0x18(%eax),%eax
80106306:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010630d:	90                   	nop
8010630e:	90                   	nop
8010630f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106312:	c9                   	leave  
80106313:	c3                   	ret    

80106314 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80106314:	55                   	push   %ebp
80106315:	89 e5                	mov    %esp,%ebp
80106317:	53                   	push   %ebx
80106318:	83 ec 14             	sub    $0x14,%esp
8010631b:	e8 65 a0 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106320:	81 c3 a0 61 00 00    	add    $0x61a0,%ebx
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80106326:	83 ec 08             	sub    $0x8,%esp
80106329:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010632c:	50                   	push   %eax
8010632d:	ff 75 08             	push   0x8(%ebp)
80106330:	e8 5a fe ff ff       	call   8010618f <argint>
80106335:	83 c4 10             	add    $0x10,%esp
80106338:	85 c0                	test   %eax,%eax
8010633a:	79 07                	jns    80106343 <argfd+0x2f>
    return -1;
8010633c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106341:	eb 4f                	jmp    80106392 <argfd+0x7e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80106343:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106346:	85 c0                	test   %eax,%eax
80106348:	78 20                	js     8010636a <argfd+0x56>
8010634a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010634d:	83 f8 0f             	cmp    $0xf,%eax
80106350:	7f 18                	jg     8010636a <argfd+0x56>
80106352:	e8 4f e8 ff ff       	call   80104ba6 <myproc>
80106357:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010635a:	83 c2 08             	add    $0x8,%edx
8010635d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106361:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106364:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106368:	75 07                	jne    80106371 <argfd+0x5d>
    return -1;
8010636a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010636f:	eb 21                	jmp    80106392 <argfd+0x7e>
  if(pfd)
80106371:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106375:	74 08                	je     8010637f <argfd+0x6b>
    *pfd = fd;
80106377:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010637a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010637d:	89 10                	mov    %edx,(%eax)
  if(pf)
8010637f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106383:	74 08                	je     8010638d <argfd+0x79>
    *pf = f;
80106385:	8b 45 10             	mov    0x10(%ebp),%eax
80106388:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010638b:	89 10                	mov    %edx,(%eax)
  return 0;
8010638d:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106392:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106395:	c9                   	leave  
80106396:	c3                   	ret    

80106397 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80106397:	55                   	push   %ebp
80106398:	89 e5                	mov    %esp,%ebp
8010639a:	53                   	push   %ebx
8010639b:	83 ec 14             	sub    $0x14,%esp
8010639e:	e8 85 a9 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801063a3:	05 1d 61 00 00       	add    $0x611d,%eax
  int fd;
  struct proc *curproc = myproc();
801063a8:	89 c3                	mov    %eax,%ebx
801063aa:	e8 f7 e7 ff ff       	call   80104ba6 <myproc>
801063af:	89 45 f0             	mov    %eax,-0x10(%ebp)

  for(fd = 0; fd < NOFILE; fd++){
801063b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801063b9:	eb 2a                	jmp    801063e5 <fdalloc+0x4e>
    if(curproc->ofile[fd] == 0){
801063bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063be:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063c1:	83 c2 08             	add    $0x8,%edx
801063c4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801063c8:	85 c0                	test   %eax,%eax
801063ca:	75 15                	jne    801063e1 <fdalloc+0x4a>
      curproc->ofile[fd] = f;
801063cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063d2:	8d 4a 08             	lea    0x8(%edx),%ecx
801063d5:	8b 55 08             	mov    0x8(%ebp),%edx
801063d8:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801063dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063df:	eb 0f                	jmp    801063f0 <fdalloc+0x59>
  for(fd = 0; fd < NOFILE; fd++){
801063e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801063e5:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801063e9:	7e d0                	jle    801063bb <fdalloc+0x24>
    }
  }
  return -1;
801063eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063f3:	c9                   	leave  
801063f4:	c3                   	ret    

801063f5 <sys_dup>:

int
sys_dup(void)
{
801063f5:	55                   	push   %ebp
801063f6:	89 e5                	mov    %esp,%ebp
801063f8:	53                   	push   %ebx
801063f9:	83 ec 14             	sub    $0x14,%esp
801063fc:	e8 84 9f ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106401:	81 c3 bf 60 00 00    	add    $0x60bf,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80106407:	83 ec 04             	sub    $0x4,%esp
8010640a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010640d:	50                   	push   %eax
8010640e:	6a 00                	push   $0x0
80106410:	6a 00                	push   $0x0
80106412:	e8 fd fe ff ff       	call   80106314 <argfd>
80106417:	83 c4 10             	add    $0x10,%esp
8010641a:	85 c0                	test   %eax,%eax
8010641c:	79 07                	jns    80106425 <sys_dup+0x30>
    return -1;
8010641e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106423:	eb 31                	jmp    80106456 <sys_dup+0x61>
  if((fd=fdalloc(f)) < 0)
80106425:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106428:	83 ec 0c             	sub    $0xc,%esp
8010642b:	50                   	push   %eax
8010642c:	e8 66 ff ff ff       	call   80106397 <fdalloc>
80106431:	83 c4 10             	add    $0x10,%esp
80106434:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106437:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010643b:	79 07                	jns    80106444 <sys_dup+0x4f>
    return -1;
8010643d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106442:	eb 12                	jmp    80106456 <sys_dup+0x61>
  filedup(f);
80106444:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106447:	83 ec 0c             	sub    $0xc,%esp
8010644a:	50                   	push   %eax
8010644b:	e8 0b af ff ff       	call   8010135b <filedup>
80106450:	83 c4 10             	add    $0x10,%esp
  return fd;
80106453:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106459:	c9                   	leave  
8010645a:	c3                   	ret    

8010645b <sys_read>:

int
sys_read(void)
{
8010645b:	55                   	push   %ebp
8010645c:	89 e5                	mov    %esp,%ebp
8010645e:	53                   	push   %ebx
8010645f:	83 ec 14             	sub    $0x14,%esp
80106462:	e8 1e 9f ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106467:	81 c3 59 60 00 00    	add    $0x6059,%ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010646d:	83 ec 04             	sub    $0x4,%esp
80106470:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106473:	50                   	push   %eax
80106474:	6a 00                	push   $0x0
80106476:	6a 00                	push   $0x0
80106478:	e8 97 fe ff ff       	call   80106314 <argfd>
8010647d:	83 c4 10             	add    $0x10,%esp
80106480:	85 c0                	test   %eax,%eax
80106482:	78 2e                	js     801064b2 <sys_read+0x57>
80106484:	83 ec 08             	sub    $0x8,%esp
80106487:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010648a:	50                   	push   %eax
8010648b:	6a 02                	push   $0x2
8010648d:	e8 fd fc ff ff       	call   8010618f <argint>
80106492:	83 c4 10             	add    $0x10,%esp
80106495:	85 c0                	test   %eax,%eax
80106497:	78 19                	js     801064b2 <sys_read+0x57>
80106499:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010649c:	83 ec 04             	sub    $0x4,%esp
8010649f:	50                   	push   %eax
801064a0:	8d 45 ec             	lea    -0x14(%ebp),%eax
801064a3:	50                   	push   %eax
801064a4:	6a 01                	push   $0x1
801064a6:	e8 21 fd ff ff       	call   801061cc <argptr>
801064ab:	83 c4 10             	add    $0x10,%esp
801064ae:	85 c0                	test   %eax,%eax
801064b0:	79 07                	jns    801064b9 <sys_read+0x5e>
    return -1;
801064b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064b7:	eb 17                	jmp    801064d0 <sys_read+0x75>
  return fileread(f, p, n);
801064b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801064bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
801064bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c2:	83 ec 04             	sub    $0x4,%esp
801064c5:	51                   	push   %ecx
801064c6:	52                   	push   %edx
801064c7:	50                   	push   %eax
801064c8:	e8 59 b0 ff ff       	call   80101526 <fileread>
801064cd:	83 c4 10             	add    $0x10,%esp
}
801064d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064d3:	c9                   	leave  
801064d4:	c3                   	ret    

801064d5 <sys_write>:

int
sys_write(void)
{
801064d5:	55                   	push   %ebp
801064d6:	89 e5                	mov    %esp,%ebp
801064d8:	53                   	push   %ebx
801064d9:	83 ec 14             	sub    $0x14,%esp
801064dc:	e8 a4 9e ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801064e1:	81 c3 df 5f 00 00    	add    $0x5fdf,%ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801064e7:	83 ec 04             	sub    $0x4,%esp
801064ea:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064ed:	50                   	push   %eax
801064ee:	6a 00                	push   $0x0
801064f0:	6a 00                	push   $0x0
801064f2:	e8 1d fe ff ff       	call   80106314 <argfd>
801064f7:	83 c4 10             	add    $0x10,%esp
801064fa:	85 c0                	test   %eax,%eax
801064fc:	78 2e                	js     8010652c <sys_write+0x57>
801064fe:	83 ec 08             	sub    $0x8,%esp
80106501:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106504:	50                   	push   %eax
80106505:	6a 02                	push   $0x2
80106507:	e8 83 fc ff ff       	call   8010618f <argint>
8010650c:	83 c4 10             	add    $0x10,%esp
8010650f:	85 c0                	test   %eax,%eax
80106511:	78 19                	js     8010652c <sys_write+0x57>
80106513:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106516:	83 ec 04             	sub    $0x4,%esp
80106519:	50                   	push   %eax
8010651a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010651d:	50                   	push   %eax
8010651e:	6a 01                	push   $0x1
80106520:	e8 a7 fc ff ff       	call   801061cc <argptr>
80106525:	83 c4 10             	add    $0x10,%esp
80106528:	85 c0                	test   %eax,%eax
8010652a:	79 07                	jns    80106533 <sys_write+0x5e>
    return -1;
8010652c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106531:	eb 17                	jmp    8010654a <sys_write+0x75>
  return filewrite(f, p, n);
80106533:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106536:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106539:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010653c:	83 ec 04             	sub    $0x4,%esp
8010653f:	51                   	push   %ecx
80106540:	52                   	push   %edx
80106541:	50                   	push   %eax
80106542:	e8 a8 b0 ff ff       	call   801015ef <filewrite>
80106547:	83 c4 10             	add    $0x10,%esp
}
8010654a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010654d:	c9                   	leave  
8010654e:	c3                   	ret    

8010654f <sys_close>:

int
sys_close(void)
{
8010654f:	55                   	push   %ebp
80106550:	89 e5                	mov    %esp,%ebp
80106552:	53                   	push   %ebx
80106553:	83 ec 14             	sub    $0x14,%esp
80106556:	e8 2a 9e ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010655b:	81 c3 65 5f 00 00    	add    $0x5f65,%ebx
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80106561:	83 ec 04             	sub    $0x4,%esp
80106564:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106567:	50                   	push   %eax
80106568:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010656b:	50                   	push   %eax
8010656c:	6a 00                	push   $0x0
8010656e:	e8 a1 fd ff ff       	call   80106314 <argfd>
80106573:	83 c4 10             	add    $0x10,%esp
80106576:	85 c0                	test   %eax,%eax
80106578:	79 07                	jns    80106581 <sys_close+0x32>
    return -1;
8010657a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010657f:	eb 27                	jmp    801065a8 <sys_close+0x59>
  myproc()->ofile[fd] = 0;
80106581:	e8 20 e6 ff ff       	call   80104ba6 <myproc>
80106586:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106589:	83 c2 08             	add    $0x8,%edx
8010658c:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106593:	00 
  fileclose(f);
80106594:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106597:	83 ec 0c             	sub    $0xc,%esp
8010659a:	50                   	push   %eax
8010659b:	e8 21 ae ff ff       	call   801013c1 <fileclose>
801065a0:	83 c4 10             	add    $0x10,%esp
  return 0;
801065a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065ab:	c9                   	leave  
801065ac:	c3                   	ret    

801065ad <sys_fstat>:

int
sys_fstat(void)
{
801065ad:	55                   	push   %ebp
801065ae:	89 e5                	mov    %esp,%ebp
801065b0:	53                   	push   %ebx
801065b1:	83 ec 14             	sub    $0x14,%esp
801065b4:	e8 cc 9d ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801065b9:	81 c3 07 5f 00 00    	add    $0x5f07,%ebx
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801065bf:	83 ec 04             	sub    $0x4,%esp
801065c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065c5:	50                   	push   %eax
801065c6:	6a 00                	push   $0x0
801065c8:	6a 00                	push   $0x0
801065ca:	e8 45 fd ff ff       	call   80106314 <argfd>
801065cf:	83 c4 10             	add    $0x10,%esp
801065d2:	85 c0                	test   %eax,%eax
801065d4:	78 17                	js     801065ed <sys_fstat+0x40>
801065d6:	83 ec 04             	sub    $0x4,%esp
801065d9:	6a 14                	push   $0x14
801065db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065de:	50                   	push   %eax
801065df:	6a 01                	push   $0x1
801065e1:	e8 e6 fb ff ff       	call   801061cc <argptr>
801065e6:	83 c4 10             	add    $0x10,%esp
801065e9:	85 c0                	test   %eax,%eax
801065eb:	79 07                	jns    801065f4 <sys_fstat+0x47>
    return -1;
801065ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065f2:	eb 13                	jmp    80106607 <sys_fstat+0x5a>
  return filestat(f, st);
801065f4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801065f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fa:	83 ec 08             	sub    $0x8,%esp
801065fd:	52                   	push   %edx
801065fe:	50                   	push   %eax
801065ff:	e8 bc ae ff ff       	call   801014c0 <filestat>
80106604:	83 c4 10             	add    $0x10,%esp
}
80106607:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010660a:	c9                   	leave  
8010660b:	c3                   	ret    

8010660c <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010660c:	55                   	push   %ebp
8010660d:	89 e5                	mov    %esp,%ebp
8010660f:	53                   	push   %ebx
80106610:	83 ec 24             	sub    $0x24,%esp
80106613:	e8 6d 9d ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106618:	81 c3 a8 5e 00 00    	add    $0x5ea8,%ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010661e:	83 ec 08             	sub    $0x8,%esp
80106621:	8d 45 d8             	lea    -0x28(%ebp),%eax
80106624:	50                   	push   %eax
80106625:	6a 00                	push   $0x0
80106627:	e8 18 fc ff ff       	call   80106244 <argstr>
8010662c:	83 c4 10             	add    $0x10,%esp
8010662f:	85 c0                	test   %eax,%eax
80106631:	78 15                	js     80106648 <sys_link+0x3c>
80106633:	83 ec 08             	sub    $0x8,%esp
80106636:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106639:	50                   	push   %eax
8010663a:	6a 01                	push   $0x1
8010663c:	e8 03 fc ff ff       	call   80106244 <argstr>
80106641:	83 c4 10             	add    $0x10,%esp
80106644:	85 c0                	test   %eax,%eax
80106646:	79 0a                	jns    80106652 <sys_link+0x46>
    return -1;
80106648:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010664d:	e9 68 01 00 00       	jmp    801067ba <sys_link+0x1ae>

  begin_op();
80106652:	e8 12 d6 ff ff       	call   80103c69 <begin_op>
  if((ip = namei(old)) == 0){
80106657:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010665a:	83 ec 0c             	sub    $0xc,%esp
8010665d:	50                   	push   %eax
8010665e:	e8 c3 c3 ff ff       	call   80102a26 <namei>
80106663:	83 c4 10             	add    $0x10,%esp
80106666:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106669:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010666d:	75 0f                	jne    8010667e <sys_link+0x72>
    end_op();
8010666f:	e8 a0 d6 ff ff       	call   80103d14 <end_op>
    return -1;
80106674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106679:	e9 3c 01 00 00       	jmp    801067ba <sys_link+0x1ae>
  }

  ilock(ip);
8010667e:	83 ec 0c             	sub    $0xc,%esp
80106681:	ff 75 f4             	push   -0xc(%ebp)
80106684:	e8 6f b7 ff ff       	call   80101df8 <ilock>
80106689:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
8010668c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010668f:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106693:	66 83 f8 01          	cmp    $0x1,%ax
80106697:	75 1d                	jne    801066b6 <sys_link+0xaa>
    iunlockput(ip);
80106699:	83 ec 0c             	sub    $0xc,%esp
8010669c:	ff 75 f4             	push   -0xc(%ebp)
8010669f:	e8 c1 b9 ff ff       	call   80102065 <iunlockput>
801066a4:	83 c4 10             	add    $0x10,%esp
    end_op();
801066a7:	e8 68 d6 ff ff       	call   80103d14 <end_op>
    return -1;
801066ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066b1:	e9 04 01 00 00       	jmp    801067ba <sys_link+0x1ae>
  }

  ip->nlink++;
801066b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066b9:	0f b7 40 56          	movzwl 0x56(%eax),%eax
801066bd:	83 c0 01             	add    $0x1,%eax
801066c0:	89 c2                	mov    %eax,%edx
801066c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066c5:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
801066c9:	83 ec 0c             	sub    $0xc,%esp
801066cc:	ff 75 f4             	push   -0xc(%ebp)
801066cf:	e8 09 b5 ff ff       	call   80101bdd <iupdate>
801066d4:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
801066d7:	83 ec 0c             	sub    $0xc,%esp
801066da:	ff 75 f4             	push   -0xc(%ebp)
801066dd:	e8 3d b8 ff ff       	call   80101f1f <iunlock>
801066e2:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
801066e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801066e8:	83 ec 08             	sub    $0x8,%esp
801066eb:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801066ee:	52                   	push   %edx
801066ef:	50                   	push   %eax
801066f0:	e8 57 c3 ff ff       	call   80102a4c <nameiparent>
801066f5:	83 c4 10             	add    $0x10,%esp
801066f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801066fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801066ff:	74 71                	je     80106772 <sys_link+0x166>
    goto bad;
  ilock(dp);
80106701:	83 ec 0c             	sub    $0xc,%esp
80106704:	ff 75 f0             	push   -0x10(%ebp)
80106707:	e8 ec b6 ff ff       	call   80101df8 <ilock>
8010670c:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
8010670f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106712:	8b 10                	mov    (%eax),%edx
80106714:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106717:	8b 00                	mov    (%eax),%eax
80106719:	39 c2                	cmp    %eax,%edx
8010671b:	75 1d                	jne    8010673a <sys_link+0x12e>
8010671d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106720:	8b 40 04             	mov    0x4(%eax),%eax
80106723:	83 ec 04             	sub    $0x4,%esp
80106726:	50                   	push   %eax
80106727:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010672a:	50                   	push   %eax
8010672b:	ff 75 f0             	push   -0x10(%ebp)
8010672e:	e8 24 c0 ff ff       	call   80102757 <dirlink>
80106733:	83 c4 10             	add    $0x10,%esp
80106736:	85 c0                	test   %eax,%eax
80106738:	79 10                	jns    8010674a <sys_link+0x13e>
    iunlockput(dp);
8010673a:	83 ec 0c             	sub    $0xc,%esp
8010673d:	ff 75 f0             	push   -0x10(%ebp)
80106740:	e8 20 b9 ff ff       	call   80102065 <iunlockput>
80106745:	83 c4 10             	add    $0x10,%esp
    goto bad;
80106748:	eb 29                	jmp    80106773 <sys_link+0x167>
  }
  iunlockput(dp);
8010674a:	83 ec 0c             	sub    $0xc,%esp
8010674d:	ff 75 f0             	push   -0x10(%ebp)
80106750:	e8 10 b9 ff ff       	call   80102065 <iunlockput>
80106755:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80106758:	83 ec 0c             	sub    $0xc,%esp
8010675b:	ff 75 f4             	push   -0xc(%ebp)
8010675e:	e8 1b b8 ff ff       	call   80101f7e <iput>
80106763:	83 c4 10             	add    $0x10,%esp

  end_op();
80106766:	e8 a9 d5 ff ff       	call   80103d14 <end_op>

  return 0;
8010676b:	b8 00 00 00 00       	mov    $0x0,%eax
80106770:	eb 48                	jmp    801067ba <sys_link+0x1ae>
    goto bad;
80106772:	90                   	nop

bad:
  ilock(ip);
80106773:	83 ec 0c             	sub    $0xc,%esp
80106776:	ff 75 f4             	push   -0xc(%ebp)
80106779:	e8 7a b6 ff ff       	call   80101df8 <ilock>
8010677e:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80106781:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106784:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106788:	83 e8 01             	sub    $0x1,%eax
8010678b:	89 c2                	mov    %eax,%edx
8010678d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106790:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80106794:	83 ec 0c             	sub    $0xc,%esp
80106797:	ff 75 f4             	push   -0xc(%ebp)
8010679a:	e8 3e b4 ff ff       	call   80101bdd <iupdate>
8010679f:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801067a2:	83 ec 0c             	sub    $0xc,%esp
801067a5:	ff 75 f4             	push   -0xc(%ebp)
801067a8:	e8 b8 b8 ff ff       	call   80102065 <iunlockput>
801067ad:	83 c4 10             	add    $0x10,%esp
  end_op();
801067b0:	e8 5f d5 ff ff       	call   80103d14 <end_op>
  return -1;
801067b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801067bd:	c9                   	leave  
801067be:	c3                   	ret    

801067bf <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801067bf:	55                   	push   %ebp
801067c0:	89 e5                	mov    %esp,%ebp
801067c2:	53                   	push   %ebx
801067c3:	83 ec 24             	sub    $0x24,%esp
801067c6:	e8 ba 9b ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801067cb:	81 c3 f5 5c 00 00    	add    $0x5cf5,%ebx
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801067d1:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801067d8:	eb 42                	jmp    8010681c <isdirempty+0x5d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801067da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067dd:	6a 10                	push   $0x10
801067df:	50                   	push   %eax
801067e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801067e3:	50                   	push   %eax
801067e4:	ff 75 08             	push   0x8(%ebp)
801067e7:	e8 68 bb ff ff       	call   80102354 <readi>
801067ec:	83 c4 10             	add    $0x10,%esp
801067ef:	83 f8 10             	cmp    $0x10,%eax
801067f2:	74 0f                	je     80106803 <isdirempty+0x44>
      panic("isdirempty: readi");
801067f4:	83 ec 0c             	sub    $0xc,%esp
801067f7:	8d 83 e8 d3 ff ff    	lea    -0x2c18(%ebx),%eax
801067fd:	50                   	push   %eax
801067fe:	e8 72 9e ff ff       	call   80100675 <panic>
    if(de.inum != 0)
80106803:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80106807:	66 85 c0             	test   %ax,%ax
8010680a:	74 07                	je     80106813 <isdirempty+0x54>
      return 0;
8010680c:	b8 00 00 00 00       	mov    $0x0,%eax
80106811:	eb 1b                	jmp    8010682e <isdirempty+0x6f>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106813:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106816:	83 c0 10             	add    $0x10,%eax
80106819:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010681c:	8b 45 08             	mov    0x8(%ebp),%eax
8010681f:	8b 50 58             	mov    0x58(%eax),%edx
80106822:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106825:	39 c2                	cmp    %eax,%edx
80106827:	77 b1                	ja     801067da <isdirempty+0x1b>
  }
  return 1;
80106829:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010682e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106831:	c9                   	leave  
80106832:	c3                   	ret    

80106833 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80106833:	55                   	push   %ebp
80106834:	89 e5                	mov    %esp,%ebp
80106836:	53                   	push   %ebx
80106837:	83 ec 34             	sub    $0x34,%esp
8010683a:	e8 46 9b ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010683f:	81 c3 81 5c 00 00    	add    $0x5c81,%ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80106845:	83 ec 08             	sub    $0x8,%esp
80106848:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010684b:	50                   	push   %eax
8010684c:	6a 00                	push   $0x0
8010684e:	e8 f1 f9 ff ff       	call   80106244 <argstr>
80106853:	83 c4 10             	add    $0x10,%esp
80106856:	85 c0                	test   %eax,%eax
80106858:	79 0a                	jns    80106864 <sys_unlink+0x31>
    return -1;
8010685a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010685f:	e9 c7 01 00 00       	jmp    80106a2b <sys_unlink+0x1f8>

  begin_op();
80106864:	e8 00 d4 ff ff       	call   80103c69 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106869:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010686c:	83 ec 08             	sub    $0x8,%esp
8010686f:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80106872:	52                   	push   %edx
80106873:	50                   	push   %eax
80106874:	e8 d3 c1 ff ff       	call   80102a4c <nameiparent>
80106879:	83 c4 10             	add    $0x10,%esp
8010687c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010687f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106883:	75 0f                	jne    80106894 <sys_unlink+0x61>
    end_op();
80106885:	e8 8a d4 ff ff       	call   80103d14 <end_op>
    return -1;
8010688a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010688f:	e9 97 01 00 00       	jmp    80106a2b <sys_unlink+0x1f8>
  }

  ilock(dp);
80106894:	83 ec 0c             	sub    $0xc,%esp
80106897:	ff 75 f4             	push   -0xc(%ebp)
8010689a:	e8 59 b5 ff ff       	call   80101df8 <ilock>
8010689f:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801068a2:	83 ec 08             	sub    $0x8,%esp
801068a5:	8d 83 fa d3 ff ff    	lea    -0x2c06(%ebx),%eax
801068ab:	50                   	push   %eax
801068ac:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801068af:	50                   	push   %eax
801068b0:	e8 aa bd ff ff       	call   8010265f <namecmp>
801068b5:	83 c4 10             	add    $0x10,%esp
801068b8:	85 c0                	test   %eax,%eax
801068ba:	0f 84 4f 01 00 00    	je     80106a0f <sys_unlink+0x1dc>
801068c0:	83 ec 08             	sub    $0x8,%esp
801068c3:	8d 83 fc d3 ff ff    	lea    -0x2c04(%ebx),%eax
801068c9:	50                   	push   %eax
801068ca:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801068cd:	50                   	push   %eax
801068ce:	e8 8c bd ff ff       	call   8010265f <namecmp>
801068d3:	83 c4 10             	add    $0x10,%esp
801068d6:	85 c0                	test   %eax,%eax
801068d8:	0f 84 31 01 00 00    	je     80106a0f <sys_unlink+0x1dc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801068de:	83 ec 04             	sub    $0x4,%esp
801068e1:	8d 45 c8             	lea    -0x38(%ebp),%eax
801068e4:	50                   	push   %eax
801068e5:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801068e8:	50                   	push   %eax
801068e9:	ff 75 f4             	push   -0xc(%ebp)
801068ec:	e8 99 bd ff ff       	call   8010268a <dirlookup>
801068f1:	83 c4 10             	add    $0x10,%esp
801068f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801068f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801068fb:	0f 84 11 01 00 00    	je     80106a12 <sys_unlink+0x1df>
    goto bad;
  ilock(ip);
80106901:	83 ec 0c             	sub    $0xc,%esp
80106904:	ff 75 f0             	push   -0x10(%ebp)
80106907:	e8 ec b4 ff ff       	call   80101df8 <ilock>
8010690c:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
8010690f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106912:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106916:	66 85 c0             	test   %ax,%ax
80106919:	7f 0f                	jg     8010692a <sys_unlink+0xf7>
    panic("unlink: nlink < 1");
8010691b:	83 ec 0c             	sub    $0xc,%esp
8010691e:	8d 83 ff d3 ff ff    	lea    -0x2c01(%ebx),%eax
80106924:	50                   	push   %eax
80106925:	e8 4b 9d ff ff       	call   80100675 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010692a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010692d:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106931:	66 83 f8 01          	cmp    $0x1,%ax
80106935:	75 25                	jne    8010695c <sys_unlink+0x129>
80106937:	83 ec 0c             	sub    $0xc,%esp
8010693a:	ff 75 f0             	push   -0x10(%ebp)
8010693d:	e8 7d fe ff ff       	call   801067bf <isdirempty>
80106942:	83 c4 10             	add    $0x10,%esp
80106945:	85 c0                	test   %eax,%eax
80106947:	75 13                	jne    8010695c <sys_unlink+0x129>
    iunlockput(ip);
80106949:	83 ec 0c             	sub    $0xc,%esp
8010694c:	ff 75 f0             	push   -0x10(%ebp)
8010694f:	e8 11 b7 ff ff       	call   80102065 <iunlockput>
80106954:	83 c4 10             	add    $0x10,%esp
    goto bad;
80106957:	e9 b7 00 00 00       	jmp    80106a13 <sys_unlink+0x1e0>
  }

  memset(&de, 0, sizeof(de));
8010695c:	83 ec 04             	sub    $0x4,%esp
8010695f:	6a 10                	push   $0x10
80106961:	6a 00                	push   $0x0
80106963:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106966:	50                   	push   %eax
80106967:	e8 88 f4 ff ff       	call   80105df4 <memset>
8010696c:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010696f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80106972:	6a 10                	push   $0x10
80106974:	50                   	push   %eax
80106975:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106978:	50                   	push   %eax
80106979:	ff 75 f4             	push   -0xc(%ebp)
8010697c:	e8 3f bb ff ff       	call   801024c0 <writei>
80106981:	83 c4 10             	add    $0x10,%esp
80106984:	83 f8 10             	cmp    $0x10,%eax
80106987:	74 0f                	je     80106998 <sys_unlink+0x165>
    panic("unlink: writei");
80106989:	83 ec 0c             	sub    $0xc,%esp
8010698c:	8d 83 11 d4 ff ff    	lea    -0x2bef(%ebx),%eax
80106992:	50                   	push   %eax
80106993:	e8 dd 9c ff ff       	call   80100675 <panic>
  if(ip->type == T_DIR){
80106998:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010699b:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010699f:	66 83 f8 01          	cmp    $0x1,%ax
801069a3:	75 21                	jne    801069c6 <sys_unlink+0x193>
    dp->nlink--;
801069a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069a8:	0f b7 40 56          	movzwl 0x56(%eax),%eax
801069ac:	83 e8 01             	sub    $0x1,%eax
801069af:	89 c2                	mov    %eax,%edx
801069b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069b4:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
801069b8:	83 ec 0c             	sub    $0xc,%esp
801069bb:	ff 75 f4             	push   -0xc(%ebp)
801069be:	e8 1a b2 ff ff       	call   80101bdd <iupdate>
801069c3:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
801069c6:	83 ec 0c             	sub    $0xc,%esp
801069c9:	ff 75 f4             	push   -0xc(%ebp)
801069cc:	e8 94 b6 ff ff       	call   80102065 <iunlockput>
801069d1:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
801069d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069d7:	0f b7 40 56          	movzwl 0x56(%eax),%eax
801069db:	83 e8 01             	sub    $0x1,%eax
801069de:	89 c2                	mov    %eax,%edx
801069e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069e3:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
801069e7:	83 ec 0c             	sub    $0xc,%esp
801069ea:	ff 75 f0             	push   -0x10(%ebp)
801069ed:	e8 eb b1 ff ff       	call   80101bdd <iupdate>
801069f2:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801069f5:	83 ec 0c             	sub    $0xc,%esp
801069f8:	ff 75 f0             	push   -0x10(%ebp)
801069fb:	e8 65 b6 ff ff       	call   80102065 <iunlockput>
80106a00:	83 c4 10             	add    $0x10,%esp

  end_op();
80106a03:	e8 0c d3 ff ff       	call   80103d14 <end_op>

  return 0;
80106a08:	b8 00 00 00 00       	mov    $0x0,%eax
80106a0d:	eb 1c                	jmp    80106a2b <sys_unlink+0x1f8>
    goto bad;
80106a0f:	90                   	nop
80106a10:	eb 01                	jmp    80106a13 <sys_unlink+0x1e0>
    goto bad;
80106a12:	90                   	nop

bad:
  iunlockput(dp);
80106a13:	83 ec 0c             	sub    $0xc,%esp
80106a16:	ff 75 f4             	push   -0xc(%ebp)
80106a19:	e8 47 b6 ff ff       	call   80102065 <iunlockput>
80106a1e:	83 c4 10             	add    $0x10,%esp
  end_op();
80106a21:	e8 ee d2 ff ff       	call   80103d14 <end_op>
  return -1;
80106a26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a2e:	c9                   	leave  
80106a2f:	c3                   	ret    

80106a30 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	53                   	push   %ebx
80106a34:	83 ec 34             	sub    $0x34,%esp
80106a37:	e8 49 99 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106a3c:	81 c3 84 5a 00 00    	add    $0x5a84,%ebx
80106a42:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106a45:	8b 55 10             	mov    0x10(%ebp),%edx
80106a48:	8b 45 14             	mov    0x14(%ebp),%eax
80106a4b:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80106a4f:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80106a53:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106a57:	83 ec 08             	sub    $0x8,%esp
80106a5a:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106a5d:	50                   	push   %eax
80106a5e:	ff 75 08             	push   0x8(%ebp)
80106a61:	e8 e6 bf ff ff       	call   80102a4c <nameiparent>
80106a66:	83 c4 10             	add    $0x10,%esp
80106a69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106a6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106a70:	75 0a                	jne    80106a7c <create+0x4c>
    return 0;
80106a72:	b8 00 00 00 00       	mov    $0x0,%eax
80106a77:	e9 98 01 00 00       	jmp    80106c14 <create+0x1e4>
  ilock(dp);
80106a7c:	83 ec 0c             	sub    $0xc,%esp
80106a7f:	ff 75 f4             	push   -0xc(%ebp)
80106a82:	e8 71 b3 ff ff       	call   80101df8 <ilock>
80106a87:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
80106a8a:	83 ec 04             	sub    $0x4,%esp
80106a8d:	6a 00                	push   $0x0
80106a8f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106a92:	50                   	push   %eax
80106a93:	ff 75 f4             	push   -0xc(%ebp)
80106a96:	e8 ef bb ff ff       	call   8010268a <dirlookup>
80106a9b:	83 c4 10             	add    $0x10,%esp
80106a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106aa1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106aa5:	74 50                	je     80106af7 <create+0xc7>
    iunlockput(dp);
80106aa7:	83 ec 0c             	sub    $0xc,%esp
80106aaa:	ff 75 f4             	push   -0xc(%ebp)
80106aad:	e8 b3 b5 ff ff       	call   80102065 <iunlockput>
80106ab2:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80106ab5:	83 ec 0c             	sub    $0xc,%esp
80106ab8:	ff 75 f0             	push   -0x10(%ebp)
80106abb:	e8 38 b3 ff ff       	call   80101df8 <ilock>
80106ac0:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106ac3:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106ac8:	75 15                	jne    80106adf <create+0xaf>
80106aca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106acd:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106ad1:	66 83 f8 02          	cmp    $0x2,%ax
80106ad5:	75 08                	jne    80106adf <create+0xaf>
      return ip;
80106ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ada:	e9 35 01 00 00       	jmp    80106c14 <create+0x1e4>
    iunlockput(ip);
80106adf:	83 ec 0c             	sub    $0xc,%esp
80106ae2:	ff 75 f0             	push   -0x10(%ebp)
80106ae5:	e8 7b b5 ff ff       	call   80102065 <iunlockput>
80106aea:	83 c4 10             	add    $0x10,%esp
    return 0;
80106aed:	b8 00 00 00 00       	mov    $0x0,%eax
80106af2:	e9 1d 01 00 00       	jmp    80106c14 <create+0x1e4>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80106af7:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106afe:	8b 00                	mov    (%eax),%eax
80106b00:	83 ec 08             	sub    $0x8,%esp
80106b03:	52                   	push   %edx
80106b04:	50                   	push   %eax
80106b05:	e8 ea af ff ff       	call   80101af4 <ialloc>
80106b0a:	83 c4 10             	add    $0x10,%esp
80106b0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106b10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106b14:	75 0f                	jne    80106b25 <create+0xf5>
    panic("create: ialloc");
80106b16:	83 ec 0c             	sub    $0xc,%esp
80106b19:	8d 83 20 d4 ff ff    	lea    -0x2be0(%ebx),%eax
80106b1f:	50                   	push   %eax
80106b20:	e8 50 9b ff ff       	call   80100675 <panic>

  ilock(ip);
80106b25:	83 ec 0c             	sub    $0xc,%esp
80106b28:	ff 75 f0             	push   -0x10(%ebp)
80106b2b:	e8 c8 b2 ff ff       	call   80101df8 <ilock>
80106b30:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80106b33:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b36:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106b3a:	66 89 50 52          	mov    %dx,0x52(%eax)
  ip->minor = minor;
80106b3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b41:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106b45:	66 89 50 54          	mov    %dx,0x54(%eax)
  ip->nlink = 1;
80106b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b4c:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
  iupdate(ip);
80106b52:	83 ec 0c             	sub    $0xc,%esp
80106b55:	ff 75 f0             	push   -0x10(%ebp)
80106b58:	e8 80 b0 ff ff       	call   80101bdd <iupdate>
80106b5d:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80106b60:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80106b65:	75 70                	jne    80106bd7 <create+0x1a7>
    dp->nlink++;  // for ".."
80106b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b6a:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106b6e:	83 c0 01             	add    $0x1,%eax
80106b71:	89 c2                	mov    %eax,%edx
80106b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b76:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80106b7a:	83 ec 0c             	sub    $0xc,%esp
80106b7d:	ff 75 f4             	push   -0xc(%ebp)
80106b80:	e8 58 b0 ff ff       	call   80101bdd <iupdate>
80106b85:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80106b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106b8b:	8b 40 04             	mov    0x4(%eax),%eax
80106b8e:	83 ec 04             	sub    $0x4,%esp
80106b91:	50                   	push   %eax
80106b92:	8d 83 fa d3 ff ff    	lea    -0x2c06(%ebx),%eax
80106b98:	50                   	push   %eax
80106b99:	ff 75 f0             	push   -0x10(%ebp)
80106b9c:	e8 b6 bb ff ff       	call   80102757 <dirlink>
80106ba1:	83 c4 10             	add    $0x10,%esp
80106ba4:	85 c0                	test   %eax,%eax
80106ba6:	78 20                	js     80106bc8 <create+0x198>
80106ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bab:	8b 40 04             	mov    0x4(%eax),%eax
80106bae:	83 ec 04             	sub    $0x4,%esp
80106bb1:	50                   	push   %eax
80106bb2:	8d 83 fc d3 ff ff    	lea    -0x2c04(%ebx),%eax
80106bb8:	50                   	push   %eax
80106bb9:	ff 75 f0             	push   -0x10(%ebp)
80106bbc:	e8 96 bb ff ff       	call   80102757 <dirlink>
80106bc1:	83 c4 10             	add    $0x10,%esp
80106bc4:	85 c0                	test   %eax,%eax
80106bc6:	79 0f                	jns    80106bd7 <create+0x1a7>
      panic("create dots");
80106bc8:	83 ec 0c             	sub    $0xc,%esp
80106bcb:	8d 83 2f d4 ff ff    	lea    -0x2bd1(%ebx),%eax
80106bd1:	50                   	push   %eax
80106bd2:	e8 9e 9a ff ff       	call   80100675 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106bd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106bda:	8b 40 04             	mov    0x4(%eax),%eax
80106bdd:	83 ec 04             	sub    $0x4,%esp
80106be0:	50                   	push   %eax
80106be1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106be4:	50                   	push   %eax
80106be5:	ff 75 f4             	push   -0xc(%ebp)
80106be8:	e8 6a bb ff ff       	call   80102757 <dirlink>
80106bed:	83 c4 10             	add    $0x10,%esp
80106bf0:	85 c0                	test   %eax,%eax
80106bf2:	79 0f                	jns    80106c03 <create+0x1d3>
    panic("create: dirlink");
80106bf4:	83 ec 0c             	sub    $0xc,%esp
80106bf7:	8d 83 3b d4 ff ff    	lea    -0x2bc5(%ebx),%eax
80106bfd:	50                   	push   %eax
80106bfe:	e8 72 9a ff ff       	call   80100675 <panic>

  iunlockput(dp);
80106c03:	83 ec 0c             	sub    $0xc,%esp
80106c06:	ff 75 f4             	push   -0xc(%ebp)
80106c09:	e8 57 b4 ff ff       	call   80102065 <iunlockput>
80106c0e:	83 c4 10             	add    $0x10,%esp

  return ip;
80106c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106c14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c17:	c9                   	leave  
80106c18:	c3                   	ret    

80106c19 <sys_open>:

int
sys_open(void)
{
80106c19:	55                   	push   %ebp
80106c1a:	89 e5                	mov    %esp,%ebp
80106c1c:	53                   	push   %ebx
80106c1d:	83 ec 24             	sub    $0x24,%esp
80106c20:	e8 60 97 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106c25:	81 c3 9b 58 00 00    	add    $0x589b,%ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106c2b:	83 ec 08             	sub    $0x8,%esp
80106c2e:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106c31:	50                   	push   %eax
80106c32:	6a 00                	push   $0x0
80106c34:	e8 0b f6 ff ff       	call   80106244 <argstr>
80106c39:	83 c4 10             	add    $0x10,%esp
80106c3c:	85 c0                	test   %eax,%eax
80106c3e:	78 15                	js     80106c55 <sys_open+0x3c>
80106c40:	83 ec 08             	sub    $0x8,%esp
80106c43:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106c46:	50                   	push   %eax
80106c47:	6a 01                	push   $0x1
80106c49:	e8 41 f5 ff ff       	call   8010618f <argint>
80106c4e:	83 c4 10             	add    $0x10,%esp
80106c51:	85 c0                	test   %eax,%eax
80106c53:	79 0a                	jns    80106c5f <sys_open+0x46>
    return -1;
80106c55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c5a:	e9 61 01 00 00       	jmp    80106dc0 <sys_open+0x1a7>

  begin_op();
80106c5f:	e8 05 d0 ff ff       	call   80103c69 <begin_op>

  if(omode & O_CREATE){
80106c64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c67:	25 00 02 00 00       	and    $0x200,%eax
80106c6c:	85 c0                	test   %eax,%eax
80106c6e:	74 2a                	je     80106c9a <sys_open+0x81>
    ip = create(path, T_FILE, 0, 0);
80106c70:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106c73:	6a 00                	push   $0x0
80106c75:	6a 00                	push   $0x0
80106c77:	6a 02                	push   $0x2
80106c79:	50                   	push   %eax
80106c7a:	e8 b1 fd ff ff       	call   80106a30 <create>
80106c7f:	83 c4 10             	add    $0x10,%esp
80106c82:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80106c85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106c89:	75 75                	jne    80106d00 <sys_open+0xe7>
      end_op();
80106c8b:	e8 84 d0 ff ff       	call   80103d14 <end_op>
      return -1;
80106c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c95:	e9 26 01 00 00       	jmp    80106dc0 <sys_open+0x1a7>
    }
  } else {
    if((ip = namei(path)) == 0){
80106c9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106c9d:	83 ec 0c             	sub    $0xc,%esp
80106ca0:	50                   	push   %eax
80106ca1:	e8 80 bd ff ff       	call   80102a26 <namei>
80106ca6:	83 c4 10             	add    $0x10,%esp
80106ca9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106cac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106cb0:	75 0f                	jne    80106cc1 <sys_open+0xa8>
      end_op();
80106cb2:	e8 5d d0 ff ff       	call   80103d14 <end_op>
      return -1;
80106cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cbc:	e9 ff 00 00 00       	jmp    80106dc0 <sys_open+0x1a7>
    }
    ilock(ip);
80106cc1:	83 ec 0c             	sub    $0xc,%esp
80106cc4:	ff 75 f4             	push   -0xc(%ebp)
80106cc7:	e8 2c b1 ff ff       	call   80101df8 <ilock>
80106ccc:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80106ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cd2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106cd6:	66 83 f8 01          	cmp    $0x1,%ax
80106cda:	75 24                	jne    80106d00 <sys_open+0xe7>
80106cdc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106cdf:	85 c0                	test   %eax,%eax
80106ce1:	74 1d                	je     80106d00 <sys_open+0xe7>
      iunlockput(ip);
80106ce3:	83 ec 0c             	sub    $0xc,%esp
80106ce6:	ff 75 f4             	push   -0xc(%ebp)
80106ce9:	e8 77 b3 ff ff       	call   80102065 <iunlockput>
80106cee:	83 c4 10             	add    $0x10,%esp
      end_op();
80106cf1:	e8 1e d0 ff ff       	call   80103d14 <end_op>
      return -1;
80106cf6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cfb:	e9 c0 00 00 00       	jmp    80106dc0 <sys_open+0x1a7>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106d00:	e8 d1 a5 ff ff       	call   801012d6 <filealloc>
80106d05:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106d08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106d0c:	74 17                	je     80106d25 <sys_open+0x10c>
80106d0e:	83 ec 0c             	sub    $0xc,%esp
80106d11:	ff 75 f0             	push   -0x10(%ebp)
80106d14:	e8 7e f6 ff ff       	call   80106397 <fdalloc>
80106d19:	83 c4 10             	add    $0x10,%esp
80106d1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106d1f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106d23:	79 2e                	jns    80106d53 <sys_open+0x13a>
    if(f)
80106d25:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106d29:	74 0e                	je     80106d39 <sys_open+0x120>
      fileclose(f);
80106d2b:	83 ec 0c             	sub    $0xc,%esp
80106d2e:	ff 75 f0             	push   -0x10(%ebp)
80106d31:	e8 8b a6 ff ff       	call   801013c1 <fileclose>
80106d36:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106d39:	83 ec 0c             	sub    $0xc,%esp
80106d3c:	ff 75 f4             	push   -0xc(%ebp)
80106d3f:	e8 21 b3 ff ff       	call   80102065 <iunlockput>
80106d44:	83 c4 10             	add    $0x10,%esp
    end_op();
80106d47:	e8 c8 cf ff ff       	call   80103d14 <end_op>
    return -1;
80106d4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d51:	eb 6d                	jmp    80106dc0 <sys_open+0x1a7>
  }
  iunlock(ip);
80106d53:	83 ec 0c             	sub    $0xc,%esp
80106d56:	ff 75 f4             	push   -0xc(%ebp)
80106d59:	e8 c1 b1 ff ff       	call   80101f1f <iunlock>
80106d5e:	83 c4 10             	add    $0x10,%esp
  end_op();
80106d61:	e8 ae cf ff ff       	call   80103d14 <end_op>

  f->type = FD_INODE;
80106d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d69:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d72:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106d75:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106d78:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d7b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106d82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d85:	83 e0 01             	and    $0x1,%eax
80106d88:	85 c0                	test   %eax,%eax
80106d8a:	0f 94 c0             	sete   %al
80106d8d:	89 c2                	mov    %eax,%edx
80106d8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d92:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106d95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d98:	83 e0 01             	and    $0x1,%eax
80106d9b:	85 c0                	test   %eax,%eax
80106d9d:	75 0a                	jne    80106da9 <sys_open+0x190>
80106d9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106da2:	83 e0 02             	and    $0x2,%eax
80106da5:	85 c0                	test   %eax,%eax
80106da7:	74 07                	je     80106db0 <sys_open+0x197>
80106da9:	b8 01 00 00 00       	mov    $0x1,%eax
80106dae:	eb 05                	jmp    80106db5 <sys_open+0x19c>
80106db0:	b8 00 00 00 00       	mov    $0x0,%eax
80106db5:	89 c2                	mov    %eax,%edx
80106db7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106dba:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106dbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106dc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106dc3:	c9                   	leave  
80106dc4:	c3                   	ret    

80106dc5 <sys_mkdir>:

int
sys_mkdir(void)
{
80106dc5:	55                   	push   %ebp
80106dc6:	89 e5                	mov    %esp,%ebp
80106dc8:	53                   	push   %ebx
80106dc9:	83 ec 14             	sub    $0x14,%esp
80106dcc:	e8 b4 95 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106dd1:	81 c3 ef 56 00 00    	add    $0x56ef,%ebx
  char *path;
  struct inode *ip;

  begin_op();
80106dd7:	e8 8d ce ff ff       	call   80103c69 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106ddc:	83 ec 08             	sub    $0x8,%esp
80106ddf:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106de2:	50                   	push   %eax
80106de3:	6a 00                	push   $0x0
80106de5:	e8 5a f4 ff ff       	call   80106244 <argstr>
80106dea:	83 c4 10             	add    $0x10,%esp
80106ded:	85 c0                	test   %eax,%eax
80106def:	78 1b                	js     80106e0c <sys_mkdir+0x47>
80106df1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106df4:	6a 00                	push   $0x0
80106df6:	6a 00                	push   $0x0
80106df8:	6a 01                	push   $0x1
80106dfa:	50                   	push   %eax
80106dfb:	e8 30 fc ff ff       	call   80106a30 <create>
80106e00:	83 c4 10             	add    $0x10,%esp
80106e03:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106e06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106e0a:	75 0c                	jne    80106e18 <sys_mkdir+0x53>
    end_op();
80106e0c:	e8 03 cf ff ff       	call   80103d14 <end_op>
    return -1;
80106e11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e16:	eb 18                	jmp    80106e30 <sys_mkdir+0x6b>
  }
  iunlockput(ip);
80106e18:	83 ec 0c             	sub    $0xc,%esp
80106e1b:	ff 75 f4             	push   -0xc(%ebp)
80106e1e:	e8 42 b2 ff ff       	call   80102065 <iunlockput>
80106e23:	83 c4 10             	add    $0x10,%esp
  end_op();
80106e26:	e8 e9 ce ff ff       	call   80103d14 <end_op>
  return 0;
80106e2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106e30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106e33:	c9                   	leave  
80106e34:	c3                   	ret    

80106e35 <sys_mknod>:

int
sys_mknod(void)
{
80106e35:	55                   	push   %ebp
80106e36:	89 e5                	mov    %esp,%ebp
80106e38:	53                   	push   %ebx
80106e39:	83 ec 14             	sub    $0x14,%esp
80106e3c:	e8 44 95 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106e41:	81 c3 7f 56 00 00    	add    $0x567f,%ebx
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106e47:	e8 1d ce ff ff       	call   80103c69 <begin_op>
  if((argstr(0, &path)) < 0 ||
80106e4c:	83 ec 08             	sub    $0x8,%esp
80106e4f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e52:	50                   	push   %eax
80106e53:	6a 00                	push   $0x0
80106e55:	e8 ea f3 ff ff       	call   80106244 <argstr>
80106e5a:	83 c4 10             	add    $0x10,%esp
80106e5d:	85 c0                	test   %eax,%eax
80106e5f:	78 4f                	js     80106eb0 <sys_mknod+0x7b>
     argint(1, &major) < 0 ||
80106e61:	83 ec 08             	sub    $0x8,%esp
80106e64:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106e67:	50                   	push   %eax
80106e68:	6a 01                	push   $0x1
80106e6a:	e8 20 f3 ff ff       	call   8010618f <argint>
80106e6f:	83 c4 10             	add    $0x10,%esp
  if((argstr(0, &path)) < 0 ||
80106e72:	85 c0                	test   %eax,%eax
80106e74:	78 3a                	js     80106eb0 <sys_mknod+0x7b>
     argint(2, &minor) < 0 ||
80106e76:	83 ec 08             	sub    $0x8,%esp
80106e79:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106e7c:	50                   	push   %eax
80106e7d:	6a 02                	push   $0x2
80106e7f:	e8 0b f3 ff ff       	call   8010618f <argint>
80106e84:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
80106e87:	85 c0                	test   %eax,%eax
80106e89:	78 25                	js     80106eb0 <sys_mknod+0x7b>
     (ip = create(path, T_DEV, major, minor)) == 0){
80106e8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106e8e:	0f bf c8             	movswl %ax,%ecx
80106e91:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106e94:	0f bf d0             	movswl %ax,%edx
80106e97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e9a:	51                   	push   %ecx
80106e9b:	52                   	push   %edx
80106e9c:	6a 03                	push   $0x3
80106e9e:	50                   	push   %eax
80106e9f:	e8 8c fb ff ff       	call   80106a30 <create>
80106ea4:	83 c4 10             	add    $0x10,%esp
80106ea7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     argint(2, &minor) < 0 ||
80106eaa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106eae:	75 0c                	jne    80106ebc <sys_mknod+0x87>
    end_op();
80106eb0:	e8 5f ce ff ff       	call   80103d14 <end_op>
    return -1;
80106eb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106eba:	eb 18                	jmp    80106ed4 <sys_mknod+0x9f>
  }
  iunlockput(ip);
80106ebc:	83 ec 0c             	sub    $0xc,%esp
80106ebf:	ff 75 f4             	push   -0xc(%ebp)
80106ec2:	e8 9e b1 ff ff       	call   80102065 <iunlockput>
80106ec7:	83 c4 10             	add    $0x10,%esp
  end_op();
80106eca:	e8 45 ce ff ff       	call   80103d14 <end_op>
  return 0;
80106ecf:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106ed4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106ed7:	c9                   	leave  
80106ed8:	c3                   	ret    

80106ed9 <sys_chdir>:

int
sys_chdir(void)
{
80106ed9:	55                   	push   %ebp
80106eda:	89 e5                	mov    %esp,%ebp
80106edc:	53                   	push   %ebx
80106edd:	83 ec 14             	sub    $0x14,%esp
80106ee0:	e8 a0 94 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106ee5:	81 c3 db 55 00 00    	add    $0x55db,%ebx
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106eeb:	e8 b6 dc ff ff       	call   80104ba6 <myproc>
80106ef0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  begin_op();
80106ef3:	e8 71 cd ff ff       	call   80103c69 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106ef8:	83 ec 08             	sub    $0x8,%esp
80106efb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106efe:	50                   	push   %eax
80106eff:	6a 00                	push   $0x0
80106f01:	e8 3e f3 ff ff       	call   80106244 <argstr>
80106f06:	83 c4 10             	add    $0x10,%esp
80106f09:	85 c0                	test   %eax,%eax
80106f0b:	78 18                	js     80106f25 <sys_chdir+0x4c>
80106f0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106f10:	83 ec 0c             	sub    $0xc,%esp
80106f13:	50                   	push   %eax
80106f14:	e8 0d bb ff ff       	call   80102a26 <namei>
80106f19:	83 c4 10             	add    $0x10,%esp
80106f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106f1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106f23:	75 0c                	jne    80106f31 <sys_chdir+0x58>
    end_op();
80106f25:	e8 ea cd ff ff       	call   80103d14 <end_op>
    return -1;
80106f2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f2f:	eb 68                	jmp    80106f99 <sys_chdir+0xc0>
  }
  ilock(ip);
80106f31:	83 ec 0c             	sub    $0xc,%esp
80106f34:	ff 75 f0             	push   -0x10(%ebp)
80106f37:	e8 bc ae ff ff       	call   80101df8 <ilock>
80106f3c:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106f3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106f42:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106f46:	66 83 f8 01          	cmp    $0x1,%ax
80106f4a:	74 1a                	je     80106f66 <sys_chdir+0x8d>
    iunlockput(ip);
80106f4c:	83 ec 0c             	sub    $0xc,%esp
80106f4f:	ff 75 f0             	push   -0x10(%ebp)
80106f52:	e8 0e b1 ff ff       	call   80102065 <iunlockput>
80106f57:	83 c4 10             	add    $0x10,%esp
    end_op();
80106f5a:	e8 b5 cd ff ff       	call   80103d14 <end_op>
    return -1;
80106f5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f64:	eb 33                	jmp    80106f99 <sys_chdir+0xc0>
  }
  iunlock(ip);
80106f66:	83 ec 0c             	sub    $0xc,%esp
80106f69:	ff 75 f0             	push   -0x10(%ebp)
80106f6c:	e8 ae af ff ff       	call   80101f1f <iunlock>
80106f71:	83 c4 10             	add    $0x10,%esp
  iput(curproc->cwd);
80106f74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f77:	8b 40 68             	mov    0x68(%eax),%eax
80106f7a:	83 ec 0c             	sub    $0xc,%esp
80106f7d:	50                   	push   %eax
80106f7e:	e8 fb af ff ff       	call   80101f7e <iput>
80106f83:	83 c4 10             	add    $0x10,%esp
  end_op();
80106f86:	e8 89 cd ff ff       	call   80103d14 <end_op>
  curproc->cwd = ip;
80106f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f8e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106f91:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80106f94:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106f99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106f9c:	c9                   	leave  
80106f9d:	c3                   	ret    

80106f9e <sys_exec>:

int
sys_exec(void)
{
80106f9e:	55                   	push   %ebp
80106f9f:	89 e5                	mov    %esp,%ebp
80106fa1:	53                   	push   %ebx
80106fa2:	81 ec 94 00 00 00    	sub    $0x94,%esp
80106fa8:	e8 d8 93 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80106fad:	81 c3 13 55 00 00    	add    $0x5513,%ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106fb3:	83 ec 08             	sub    $0x8,%esp
80106fb6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106fb9:	50                   	push   %eax
80106fba:	6a 00                	push   $0x0
80106fbc:	e8 83 f2 ff ff       	call   80106244 <argstr>
80106fc1:	83 c4 10             	add    $0x10,%esp
80106fc4:	85 c0                	test   %eax,%eax
80106fc6:	78 18                	js     80106fe0 <sys_exec+0x42>
80106fc8:	83 ec 08             	sub    $0x8,%esp
80106fcb:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106fd1:	50                   	push   %eax
80106fd2:	6a 01                	push   $0x1
80106fd4:	e8 b6 f1 ff ff       	call   8010618f <argint>
80106fd9:	83 c4 10             	add    $0x10,%esp
80106fdc:	85 c0                	test   %eax,%eax
80106fde:	79 0a                	jns    80106fea <sys_exec+0x4c>
    return -1;
80106fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fe5:	e9 c6 00 00 00       	jmp    801070b0 <sys_exec+0x112>
  }
  memset(argv, 0, sizeof(argv));
80106fea:	83 ec 04             	sub    $0x4,%esp
80106fed:	68 80 00 00 00       	push   $0x80
80106ff2:	6a 00                	push   $0x0
80106ff4:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106ffa:	50                   	push   %eax
80106ffb:	e8 f4 ed ff ff       	call   80105df4 <memset>
80107000:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80107003:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010700a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010700d:	83 f8 1f             	cmp    $0x1f,%eax
80107010:	76 0a                	jbe    8010701c <sys_exec+0x7e>
      return -1;
80107012:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107017:	e9 94 00 00 00       	jmp    801070b0 <sys_exec+0x112>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010701c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010701f:	c1 e0 02             	shl    $0x2,%eax
80107022:	89 c2                	mov    %eax,%edx
80107024:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010702a:	01 c2                	add    %eax,%edx
8010702c:	83 ec 08             	sub    $0x8,%esp
8010702f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80107035:	50                   	push   %eax
80107036:	52                   	push   %edx
80107037:	e8 92 f0 ff ff       	call   801060ce <fetchint>
8010703c:	83 c4 10             	add    $0x10,%esp
8010703f:	85 c0                	test   %eax,%eax
80107041:	79 07                	jns    8010704a <sys_exec+0xac>
      return -1;
80107043:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107048:	eb 66                	jmp    801070b0 <sys_exec+0x112>
    if(uarg == 0){
8010704a:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107050:	85 c0                	test   %eax,%eax
80107052:	75 27                	jne    8010707b <sys_exec+0xdd>
      argv[i] = 0;
80107054:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107057:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010705e:	00 00 00 00 
      break;
80107062:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80107063:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107066:	83 ec 08             	sub    $0x8,%esp
80107069:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010706f:	52                   	push   %edx
80107070:	50                   	push   %eax
80107071:	e8 28 9d ff ff       	call   80100d9e <exec>
80107076:	83 c4 10             	add    $0x10,%esp
80107079:	eb 35                	jmp    801070b0 <sys_exec+0x112>
    if(fetchstr(uarg, &argv[i]) < 0)
8010707b:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107084:	c1 e0 02             	shl    $0x2,%eax
80107087:	01 c2                	add    %eax,%edx
80107089:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010708f:	83 ec 08             	sub    $0x8,%esp
80107092:	52                   	push   %edx
80107093:	50                   	push   %eax
80107094:	e8 84 f0 ff ff       	call   8010611d <fetchstr>
80107099:	83 c4 10             	add    $0x10,%esp
8010709c:	85 c0                	test   %eax,%eax
8010709e:	79 07                	jns    801070a7 <sys_exec+0x109>
      return -1;
801070a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070a5:	eb 09                	jmp    801070b0 <sys_exec+0x112>
  for(i=0;; i++){
801070a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
801070ab:	e9 5a ff ff ff       	jmp    8010700a <sys_exec+0x6c>
}
801070b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801070b3:	c9                   	leave  
801070b4:	c3                   	ret    

801070b5 <sys_pipe>:

int
sys_pipe(void)
{
801070b5:	55                   	push   %ebp
801070b6:	89 e5                	mov    %esp,%ebp
801070b8:	53                   	push   %ebx
801070b9:	83 ec 24             	sub    $0x24,%esp
801070bc:	e8 c4 92 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801070c1:	81 c3 ff 53 00 00    	add    $0x53ff,%ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801070c7:	83 ec 04             	sub    $0x4,%esp
801070ca:	6a 08                	push   $0x8
801070cc:	8d 45 ec             	lea    -0x14(%ebp),%eax
801070cf:	50                   	push   %eax
801070d0:	6a 00                	push   $0x0
801070d2:	e8 f5 f0 ff ff       	call   801061cc <argptr>
801070d7:	83 c4 10             	add    $0x10,%esp
801070da:	85 c0                	test   %eax,%eax
801070dc:	79 0a                	jns    801070e8 <sys_pipe+0x33>
    return -1;
801070de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070e3:	e9 ae 00 00 00       	jmp    80107196 <sys_pipe+0xe1>
  if(pipealloc(&rf, &wf) < 0)
801070e8:	83 ec 08             	sub    $0x8,%esp
801070eb:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801070ee:	50                   	push   %eax
801070ef:	8d 45 e8             	lea    -0x18(%ebp),%eax
801070f2:	50                   	push   %eax
801070f3:	e8 58 d5 ff ff       	call   80104650 <pipealloc>
801070f8:	83 c4 10             	add    $0x10,%esp
801070fb:	85 c0                	test   %eax,%eax
801070fd:	79 0a                	jns    80107109 <sys_pipe+0x54>
    return -1;
801070ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107104:	e9 8d 00 00 00       	jmp    80107196 <sys_pipe+0xe1>
  fd0 = -1;
80107109:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80107110:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107113:	83 ec 0c             	sub    $0xc,%esp
80107116:	50                   	push   %eax
80107117:	e8 7b f2 ff ff       	call   80106397 <fdalloc>
8010711c:	83 c4 10             	add    $0x10,%esp
8010711f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107122:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107126:	78 18                	js     80107140 <sys_pipe+0x8b>
80107128:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010712b:	83 ec 0c             	sub    $0xc,%esp
8010712e:	50                   	push   %eax
8010712f:	e8 63 f2 ff ff       	call   80106397 <fdalloc>
80107134:	83 c4 10             	add    $0x10,%esp
80107137:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010713a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010713e:	79 3e                	jns    8010717e <sys_pipe+0xc9>
    if(fd0 >= 0)
80107140:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107144:	78 13                	js     80107159 <sys_pipe+0xa4>
      myproc()->ofile[fd0] = 0;
80107146:	e8 5b da ff ff       	call   80104ba6 <myproc>
8010714b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010714e:	83 c2 08             	add    $0x8,%edx
80107151:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80107158:	00 
    fileclose(rf);
80107159:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010715c:	83 ec 0c             	sub    $0xc,%esp
8010715f:	50                   	push   %eax
80107160:	e8 5c a2 ff ff       	call   801013c1 <fileclose>
80107165:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80107168:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010716b:	83 ec 0c             	sub    $0xc,%esp
8010716e:	50                   	push   %eax
8010716f:	e8 4d a2 ff ff       	call   801013c1 <fileclose>
80107174:	83 c4 10             	add    $0x10,%esp
    return -1;
80107177:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010717c:	eb 18                	jmp    80107196 <sys_pipe+0xe1>
  }
  fd[0] = fd0;
8010717e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107181:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107184:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80107186:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107189:	8d 50 04             	lea    0x4(%eax),%edx
8010718c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010718f:	89 02                	mov    %eax,(%edx)
  return 0;
80107191:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107196:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107199:	c9                   	leave  
8010719a:	c3                   	ret    

8010719b <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
8010719b:	55                   	push   %ebp
8010719c:	89 e5                	mov    %esp,%ebp
8010719e:	53                   	push   %ebx
8010719f:	83 ec 04             	sub    $0x4,%esp
801071a2:	e8 81 9b ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801071a7:	05 19 53 00 00       	add    $0x5319,%eax
  return fork();
801071ac:	89 c3                	mov    %eax,%ebx
801071ae:	e8 4d dd ff ff       	call   80104f00 <fork>
}
801071b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801071b6:	c9                   	leave  
801071b7:	c3                   	ret    

801071b8 <sys_exit>:

int
sys_exit(void)
{
801071b8:	55                   	push   %ebp
801071b9:	89 e5                	mov    %esp,%ebp
801071bb:	53                   	push   %ebx
801071bc:	83 ec 04             	sub    $0x4,%esp
801071bf:	e8 64 9b ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801071c4:	05 fc 52 00 00       	add    $0x52fc,%eax
  exit();
801071c9:	89 c3                	mov    %eax,%ebx
801071cb:	e8 b6 de ff ff       	call   80105086 <exit>
  return 0;  // not reached
801071d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801071d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801071d8:	c9                   	leave  
801071d9:	c3                   	ret    

801071da <sys_wait>:

int
sys_wait(void)
{
801071da:	55                   	push   %ebp
801071db:	89 e5                	mov    %esp,%ebp
801071dd:	53                   	push   %ebx
801071de:	83 ec 04             	sub    $0x4,%esp
801071e1:	e8 42 9b ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801071e6:	05 da 52 00 00       	add    $0x52da,%eax
  return wait();
801071eb:	89 c3                	mov    %eax,%ebx
801071ed:	e8 cc df ff ff       	call   801051be <wait>
}
801071f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801071f5:	c9                   	leave  
801071f6:	c3                   	ret    

801071f7 <sys_kill>:

int
sys_kill(void)
{
801071f7:	55                   	push   %ebp
801071f8:	89 e5                	mov    %esp,%ebp
801071fa:	53                   	push   %ebx
801071fb:	83 ec 14             	sub    $0x14,%esp
801071fe:	e8 82 91 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80107203:	81 c3 bd 52 00 00    	add    $0x52bd,%ebx
  int pid;

  if(argint(0, &pid) < 0)
80107209:	83 ec 08             	sub    $0x8,%esp
8010720c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010720f:	50                   	push   %eax
80107210:	6a 00                	push   $0x0
80107212:	e8 78 ef ff ff       	call   8010618f <argint>
80107217:	83 c4 10             	add    $0x10,%esp
8010721a:	85 c0                	test   %eax,%eax
8010721c:	79 07                	jns    80107225 <sys_kill+0x2e>
    return -1;
8010721e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107223:	eb 0f                	jmp    80107234 <sys_kill+0x3d>
  return kill(pid);
80107225:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107228:	83 ec 0c             	sub    $0xc,%esp
8010722b:	50                   	push   %eax
8010722c:	e8 65 e4 ff ff       	call   80105696 <kill>
80107231:	83 c4 10             	add    $0x10,%esp
}
80107234:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107237:	c9                   	leave  
80107238:	c3                   	ret    

80107239 <sys_getpid>:

int
sys_getpid(void)
{
80107239:	55                   	push   %ebp
8010723a:	89 e5                	mov    %esp,%ebp
8010723c:	53                   	push   %ebx
8010723d:	83 ec 04             	sub    $0x4,%esp
80107240:	e8 e3 9a ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107245:	05 7b 52 00 00       	add    $0x527b,%eax
  return myproc()->pid;
8010724a:	89 c3                	mov    %eax,%ebx
8010724c:	e8 55 d9 ff ff       	call   80104ba6 <myproc>
80107251:	8b 40 10             	mov    0x10(%eax),%eax
}
80107254:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107257:	c9                   	leave  
80107258:	c3                   	ret    

80107259 <sys_sbrk>:

int
sys_sbrk(void)
{
80107259:	55                   	push   %ebp
8010725a:	89 e5                	mov    %esp,%ebp
8010725c:	53                   	push   %ebx
8010725d:	83 ec 14             	sub    $0x14,%esp
80107260:	e8 20 91 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80107265:	81 c3 5b 52 00 00    	add    $0x525b,%ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010726b:	83 ec 08             	sub    $0x8,%esp
8010726e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107271:	50                   	push   %eax
80107272:	6a 00                	push   $0x0
80107274:	e8 16 ef ff ff       	call   8010618f <argint>
80107279:	83 c4 10             	add    $0x10,%esp
8010727c:	85 c0                	test   %eax,%eax
8010727e:	79 07                	jns    80107287 <sys_sbrk+0x2e>
    return -1;
80107280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107285:	eb 27                	jmp    801072ae <sys_sbrk+0x55>
  addr = myproc()->sz;
80107287:	e8 1a d9 ff ff       	call   80104ba6 <myproc>
8010728c:	8b 00                	mov    (%eax),%eax
8010728e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80107291:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107294:	83 ec 0c             	sub    $0xc,%esp
80107297:	50                   	push   %eax
80107298:	e8 b9 db ff ff       	call   80104e56 <growproc>
8010729d:	83 c4 10             	add    $0x10,%esp
801072a0:	85 c0                	test   %eax,%eax
801072a2:	79 07                	jns    801072ab <sys_sbrk+0x52>
    return -1;
801072a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072a9:	eb 03                	jmp    801072ae <sys_sbrk+0x55>
  return addr;
801072ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801072ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801072b1:	c9                   	leave  
801072b2:	c3                   	ret    

801072b3 <sys_sleep>:

int
sys_sleep(void)
{
801072b3:	55                   	push   %ebp
801072b4:	89 e5                	mov    %esp,%ebp
801072b6:	53                   	push   %ebx
801072b7:	83 ec 14             	sub    $0x14,%esp
801072ba:	e8 c6 90 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801072bf:	81 c3 01 52 00 00    	add    $0x5201,%ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801072c5:	83 ec 08             	sub    $0x8,%esp
801072c8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801072cb:	50                   	push   %eax
801072cc:	6a 00                	push   $0x0
801072ce:	e8 bc ee ff ff       	call   8010618f <argint>
801072d3:	83 c4 10             	add    $0x10,%esp
801072d6:	85 c0                	test   %eax,%eax
801072d8:	79 0a                	jns    801072e4 <sys_sleep+0x31>
    return -1;
801072da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072df:	e9 86 00 00 00       	jmp    8010736a <sys_sleep+0xb7>
  acquire(&tickslock);
801072e4:	83 ec 0c             	sub    $0xc,%esp
801072e7:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
801072ed:	50                   	push   %eax
801072ee:	e8 0f e8 ff ff       	call   80105b02 <acquire>
801072f3:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801072f6:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
801072fc:	8b 00                	mov    (%eax),%eax
801072fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80107301:	eb 3e                	jmp    80107341 <sys_sleep+0x8e>
    if(myproc()->killed){
80107303:	e8 9e d8 ff ff       	call   80104ba6 <myproc>
80107308:	8b 40 24             	mov    0x24(%eax),%eax
8010730b:	85 c0                	test   %eax,%eax
8010730d:	74 19                	je     80107328 <sys_sleep+0x75>
      release(&tickslock);
8010730f:	83 ec 0c             	sub    $0xc,%esp
80107312:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
80107318:	50                   	push   %eax
80107319:	e8 5f e8 ff ff       	call   80105b7d <release>
8010731e:	83 c4 10             	add    $0x10,%esp
      return -1;
80107321:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107326:	eb 42                	jmp    8010736a <sys_sleep+0xb7>
    }
    sleep(&ticks, &tickslock);
80107328:	83 ec 08             	sub    $0x8,%esp
8010732b:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
80107331:	50                   	push   %eax
80107332:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
80107338:	50                   	push   %eax
80107339:	e8 fe e1 ff ff       	call   8010553c <sleep>
8010733e:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
80107341:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
80107347:	8b 00                	mov    (%eax),%eax
80107349:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010734c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010734f:	39 d0                	cmp    %edx,%eax
80107351:	72 b0                	jb     80107303 <sys_sleep+0x50>
  }
  release(&tickslock);
80107353:	83 ec 0c             	sub    $0xc,%esp
80107356:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
8010735c:	50                   	push   %eax
8010735d:	e8 1b e8 ff ff       	call   80105b7d <release>
80107362:	83 c4 10             	add    $0x10,%esp
  return 0;
80107365:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010736a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010736d:	c9                   	leave  
8010736e:	c3                   	ret    

8010736f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
8010736f:	55                   	push   %ebp
80107370:	89 e5                	mov    %esp,%ebp
80107372:	53                   	push   %ebx
80107373:	83 ec 14             	sub    $0x14,%esp
80107376:	e8 0a 90 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
8010737b:	81 c3 45 51 00 00    	add    $0x5145,%ebx
  uint xticks;

  acquire(&tickslock);
80107381:	83 ec 0c             	sub    $0xc,%esp
80107384:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
8010738a:	50                   	push   %eax
8010738b:	e8 72 e7 ff ff       	call   80105b02 <acquire>
80107390:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80107393:	c7 c0 f4 64 11 80    	mov    $0x801164f4,%eax
80107399:	8b 00                	mov    (%eax),%eax
8010739b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010739e:	83 ec 0c             	sub    $0xc,%esp
801073a1:	c7 c0 c0 64 11 80    	mov    $0x801164c0,%eax
801073a7:	50                   	push   %eax
801073a8:	e8 d0 e7 ff ff       	call   80105b7d <release>
801073ad:	83 c4 10             	add    $0x10,%esp
  return xticks;
801073b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801073b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801073b6:	c9                   	leave  
801073b7:	c3                   	ret    

801073b8 <sys_random>:


int sys_random(void){
801073b8:	55                   	push   %ebp
801073b9:	89 e5                	mov    %esp,%ebp
801073bb:	53                   	push   %ebx
801073bc:	83 ec 14             	sub    $0x14,%esp
801073bf:	e8 64 99 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801073c4:	05 fc 50 00 00       	add    $0x50fc,%eax
  int rand_no;
  rand_no=random();
801073c9:	89 c3                	mov    %eax,%ebx
801073cb:	e8 78 e4 ff ff       	call   80105848 <random>
801073d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // cprintf("%d",rand_no);
  return rand_no;
801073d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801073d9:	c9                   	leave  
801073da:	c3                   	ret    

801073db <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801073db:	1e                   	push   %ds
  pushl %es
801073dc:	06                   	push   %es
  pushl %fs
801073dd:	0f a0                	push   %fs
  pushl %gs
801073df:	0f a8                	push   %gs
  pushal
801073e1:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801073e2:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801073e6:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801073e8:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801073ea:	54                   	push   %esp
  call trap
801073eb:	e8 25 02 00 00       	call   80107615 <trap>
  addl $4, %esp
801073f0:	83 c4 04             	add    $0x4,%esp

801073f3 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801073f3:	61                   	popa   
  popl %gs
801073f4:	0f a9                	pop    %gs
  popl %fs
801073f6:	0f a1                	pop    %fs
  popl %es
801073f8:	07                   	pop    %es
  popl %ds
801073f9:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801073fa:	83 c4 08             	add    $0x8,%esp
  iret
801073fd:	cf                   	iret   

801073fe <lidt>:
{
801073fe:	55                   	push   %ebp
801073ff:	89 e5                	mov    %esp,%ebp
80107401:	83 ec 10             	sub    $0x10,%esp
80107404:	e8 1f 99 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107409:	05 b7 50 00 00       	add    $0x50b7,%eax
  pd[0] = size-1;
8010740e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107411:	83 e8 01             	sub    $0x1,%eax
80107414:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107418:	8b 45 08             	mov    0x8(%ebp),%eax
8010741b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010741f:	8b 45 08             	mov    0x8(%ebp),%eax
80107422:	c1 e8 10             	shr    $0x10,%eax
80107425:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80107429:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010742c:	0f 01 18             	lidtl  (%eax)
}
8010742f:	90                   	nop
80107430:	c9                   	leave  
80107431:	c3                   	ret    

80107432 <rcr2>:

static inline uint
rcr2(void)
{
80107432:	55                   	push   %ebp
80107433:	89 e5                	mov    %esp,%ebp
80107435:	83 ec 10             	sub    $0x10,%esp
80107438:	e8 eb 98 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
8010743d:	05 83 50 00 00       	add    $0x5083,%eax
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107442:	0f 20 d0             	mov    %cr2,%eax
80107445:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80107448:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010744b:	c9                   	leave  
8010744c:	c3                   	ret    

8010744d <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010744d:	55                   	push   %ebp
8010744e:	89 e5                	mov    %esp,%ebp
80107450:	53                   	push   %ebx
80107451:	83 ec 14             	sub    $0x14,%esp
80107454:	e8 cf 98 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107459:	05 67 50 00 00       	add    $0x5067,%eax
  int i;

  for(i = 0; i < 256; i++)
8010745e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107465:	e9 c7 00 00 00       	jmp    80107531 <tvinit+0xe4>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010746a:	c7 c2 08 c0 10 80    	mov    $0x8010c008,%edx
80107470:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80107473:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107476:	89 d1                	mov    %edx,%ecx
80107478:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010747b:	66 89 8c d0 00 98 00 	mov    %cx,0x9800(%eax,%edx,8)
80107482:	00 
80107483:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107486:	66 c7 84 d0 02 98 00 	movw   $0x8,0x9802(%eax,%edx,8)
8010748d:	00 08 00 
80107490:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107493:	0f b6 8c d0 04 98 00 	movzbl 0x9804(%eax,%edx,8),%ecx
8010749a:	00 
8010749b:	83 e1 e0             	and    $0xffffffe0,%ecx
8010749e:	88 8c d0 04 98 00 00 	mov    %cl,0x9804(%eax,%edx,8)
801074a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801074a8:	0f b6 8c d0 04 98 00 	movzbl 0x9804(%eax,%edx,8),%ecx
801074af:	00 
801074b0:	83 e1 1f             	and    $0x1f,%ecx
801074b3:	88 8c d0 04 98 00 00 	mov    %cl,0x9804(%eax,%edx,8)
801074ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801074bd:	0f b6 8c d0 05 98 00 	movzbl 0x9805(%eax,%edx,8),%ecx
801074c4:	00 
801074c5:	83 e1 f0             	and    $0xfffffff0,%ecx
801074c8:	83 c9 0e             	or     $0xe,%ecx
801074cb:	88 8c d0 05 98 00 00 	mov    %cl,0x9805(%eax,%edx,8)
801074d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801074d5:	0f b6 8c d0 05 98 00 	movzbl 0x9805(%eax,%edx,8),%ecx
801074dc:	00 
801074dd:	83 e1 ef             	and    $0xffffffef,%ecx
801074e0:	88 8c d0 05 98 00 00 	mov    %cl,0x9805(%eax,%edx,8)
801074e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801074ea:	0f b6 8c d0 05 98 00 	movzbl 0x9805(%eax,%edx,8),%ecx
801074f1:	00 
801074f2:	83 e1 9f             	and    $0xffffff9f,%ecx
801074f5:	88 8c d0 05 98 00 00 	mov    %cl,0x9805(%eax,%edx,8)
801074fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801074ff:	0f b6 8c d0 05 98 00 	movzbl 0x9805(%eax,%edx,8),%ecx
80107506:	00 
80107507:	83 c9 80             	or     $0xffffff80,%ecx
8010750a:	88 8c d0 05 98 00 00 	mov    %cl,0x9805(%eax,%edx,8)
80107511:	c7 c2 08 c0 10 80    	mov    $0x8010c008,%edx
80107517:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010751a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
8010751d:	c1 ea 10             	shr    $0x10,%edx
80107520:	89 d1                	mov    %edx,%ecx
80107522:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107525:	66 89 8c d0 06 98 00 	mov    %cx,0x9806(%eax,%edx,8)
8010752c:	00 
  for(i = 0; i < 256; i++)
8010752d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107531:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80107538:	0f 8e 2c ff ff ff    	jle    8010746a <tvinit+0x1d>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010753e:	c7 c2 08 c0 10 80    	mov    $0x8010c008,%edx
80107544:	8b 92 00 01 00 00    	mov    0x100(%edx),%edx
8010754a:	66 89 90 00 9a 00 00 	mov    %dx,0x9a00(%eax)
80107551:	66 c7 80 02 9a 00 00 	movw   $0x8,0x9a02(%eax)
80107558:	08 00 
8010755a:	0f b6 90 04 9a 00 00 	movzbl 0x9a04(%eax),%edx
80107561:	83 e2 e0             	and    $0xffffffe0,%edx
80107564:	88 90 04 9a 00 00    	mov    %dl,0x9a04(%eax)
8010756a:	0f b6 90 04 9a 00 00 	movzbl 0x9a04(%eax),%edx
80107571:	83 e2 1f             	and    $0x1f,%edx
80107574:	88 90 04 9a 00 00    	mov    %dl,0x9a04(%eax)
8010757a:	0f b6 90 05 9a 00 00 	movzbl 0x9a05(%eax),%edx
80107581:	83 ca 0f             	or     $0xf,%edx
80107584:	88 90 05 9a 00 00    	mov    %dl,0x9a05(%eax)
8010758a:	0f b6 90 05 9a 00 00 	movzbl 0x9a05(%eax),%edx
80107591:	83 e2 ef             	and    $0xffffffef,%edx
80107594:	88 90 05 9a 00 00    	mov    %dl,0x9a05(%eax)
8010759a:	0f b6 90 05 9a 00 00 	movzbl 0x9a05(%eax),%edx
801075a1:	83 ca 60             	or     $0x60,%edx
801075a4:	88 90 05 9a 00 00    	mov    %dl,0x9a05(%eax)
801075aa:	0f b6 90 05 9a 00 00 	movzbl 0x9a05(%eax),%edx
801075b1:	83 ca 80             	or     $0xffffff80,%edx
801075b4:	88 90 05 9a 00 00    	mov    %dl,0x9a05(%eax)
801075ba:	c7 c2 08 c0 10 80    	mov    $0x8010c008,%edx
801075c0:	8b 92 00 01 00 00    	mov    0x100(%edx),%edx
801075c6:	c1 ea 10             	shr    $0x10,%edx
801075c9:	66 89 90 06 9a 00 00 	mov    %dx,0x9a06(%eax)

  initlock(&tickslock, "time");
801075d0:	83 ec 08             	sub    $0x8,%esp
801075d3:	8d 90 4c d4 ff ff    	lea    -0x2bb4(%eax),%edx
801075d9:	52                   	push   %edx
801075da:	8d 90 00 a0 00 00    	lea    0xa000(%eax),%edx
801075e0:	52                   	push   %edx
801075e1:	89 c3                	mov    %eax,%ebx
801075e3:	e8 ee e4 ff ff       	call   80105ad6 <initlock>
801075e8:	83 c4 10             	add    $0x10,%esp
}
801075eb:	90                   	nop
801075ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801075ef:	c9                   	leave  
801075f0:	c3                   	ret    

801075f1 <idtinit>:

void
idtinit(void)
{
801075f1:	55                   	push   %ebp
801075f2:	89 e5                	mov    %esp,%ebp
801075f4:	e8 2f 97 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801075f9:	05 c7 4e 00 00       	add    $0x4ec7,%eax
  lidt(idt, sizeof(idt));
801075fe:	68 00 08 00 00       	push   $0x800
80107603:	8d 80 00 98 00 00    	lea    0x9800(%eax),%eax
80107609:	50                   	push   %eax
8010760a:	e8 ef fd ff ff       	call   801073fe <lidt>
8010760f:	83 c4 08             	add    $0x8,%esp
}
80107612:	90                   	nop
80107613:	c9                   	leave  
80107614:	c3                   	ret    

80107615 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80107615:	55                   	push   %ebp
80107616:	89 e5                	mov    %esp,%ebp
80107618:	57                   	push   %edi
80107619:	56                   	push   %esi
8010761a:	53                   	push   %ebx
8010761b:	83 ec 1c             	sub    $0x1c,%esp
8010761e:	e8 62 8d ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80107623:	81 c3 9d 4e 00 00    	add    $0x4e9d,%ebx
  if(tf->trapno == T_SYSCALL){
80107629:	8b 45 08             	mov    0x8(%ebp),%eax
8010762c:	8b 40 30             	mov    0x30(%eax),%eax
8010762f:	83 f8 40             	cmp    $0x40,%eax
80107632:	75 3b                	jne    8010766f <trap+0x5a>
    if(myproc()->killed)
80107634:	e8 6d d5 ff ff       	call   80104ba6 <myproc>
80107639:	8b 40 24             	mov    0x24(%eax),%eax
8010763c:	85 c0                	test   %eax,%eax
8010763e:	74 05                	je     80107645 <trap+0x30>
      exit();
80107640:	e8 41 da ff ff       	call   80105086 <exit>
    myproc()->tf = tf;
80107645:	e8 5c d5 ff ff       	call   80104ba6 <myproc>
8010764a:	8b 55 08             	mov    0x8(%ebp),%edx
8010764d:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80107650:	e8 30 ec ff ff       	call   80106285 <syscall>
    if(myproc()->killed)
80107655:	e8 4c d5 ff ff       	call   80104ba6 <myproc>
8010765a:	8b 40 24             	mov    0x24(%eax),%eax
8010765d:	85 c0                	test   %eax,%eax
8010765f:	0f 84 1e 02 00 00    	je     80107883 <.L28+0x81>
      exit();
80107665:	e8 1c da ff ff       	call   80105086 <exit>
    return;
8010766a:	e9 14 02 00 00       	jmp    80107883 <.L28+0x81>
  }

  switch(tf->trapno){
8010766f:	8b 45 08             	mov    0x8(%ebp),%eax
80107672:	8b 40 30             	mov    0x30(%eax),%eax
80107675:	83 e8 20             	sub    $0x20,%eax
80107678:	83 f8 1f             	cmp    $0x1f,%eax
8010767b:	0f 87 c4 00 00 00    	ja     80107745 <.L13>
80107681:	c1 e0 02             	shl    $0x2,%eax
80107684:	8b 84 18 f4 d4 ff ff 	mov    -0x2b0c(%eax,%ebx,1),%eax
8010768b:	01 d8                	add    %ebx,%eax
8010768d:	ff e0                	jmp    *%eax

8010768f <.L20>:
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
8010768f:	e8 51 d4 ff ff       	call   80104ae5 <cpuid>
80107694:	85 c0                	test   %eax,%eax
80107696:	75 45                	jne    801076dd <.L20+0x4e>
      acquire(&tickslock);
80107698:	83 ec 0c             	sub    $0xc,%esp
8010769b:	8d 83 00 a0 00 00    	lea    0xa000(%ebx),%eax
801076a1:	50                   	push   %eax
801076a2:	e8 5b e4 ff ff       	call   80105b02 <acquire>
801076a7:	83 c4 10             	add    $0x10,%esp
      ticks++;
801076aa:	8b 83 34 a0 00 00    	mov    0xa034(%ebx),%eax
801076b0:	83 c0 01             	add    $0x1,%eax
801076b3:	89 83 34 a0 00 00    	mov    %eax,0xa034(%ebx)
      wakeup(&ticks);
801076b9:	83 ec 0c             	sub    $0xc,%esp
801076bc:	8d 83 34 a0 00 00    	lea    0xa034(%ebx),%eax
801076c2:	50                   	push   %eax
801076c3:	e8 84 df ff ff       	call   8010564c <wakeup>
801076c8:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801076cb:	83 ec 0c             	sub    $0xc,%esp
801076ce:	8d 83 00 a0 00 00    	lea    0xa000(%ebx),%eax
801076d4:	50                   	push   %eax
801076d5:	e8 a3 e4 ff ff       	call   80105b7d <release>
801076da:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
801076dd:	e8 c9 bf ff ff       	call   801036ab <lapiceoi>
    break;
801076e2:	e9 1c 01 00 00       	jmp    80107803 <.L28+0x1>

801076e7 <.L17>:
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801076e7:	e8 ea b6 ff ff       	call   80102dd6 <ideintr>
    lapiceoi();
801076ec:	e8 ba bf ff ff       	call   801036ab <lapiceoi>
    break;
801076f1:	e9 0d 01 00 00       	jmp    80107803 <.L28+0x1>

801076f6 <.L19>:
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801076f6:	e8 a6 bd ff ff       	call   801034a1 <kbdintr>
    lapiceoi();
801076fb:	e8 ab bf ff ff       	call   801036ab <lapiceoi>
    break;
80107700:	e9 fe 00 00 00       	jmp    80107803 <.L28+0x1>

80107705 <.L18>:
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80107705:	e8 8f 03 00 00       	call   80107a99 <uartintr>
    lapiceoi();
8010770a:	e8 9c bf ff ff       	call   801036ab <lapiceoi>
    break;
8010770f:	e9 ef 00 00 00       	jmp    80107803 <.L28+0x1>

80107714 <.L14>:
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107714:	8b 45 08             	mov    0x8(%ebp),%eax
80107717:	8b 78 38             	mov    0x38(%eax),%edi
            cpuid(), tf->cs, tf->eip);
8010771a:	8b 45 08             	mov    0x8(%ebp),%eax
8010771d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107721:	0f b7 f0             	movzwl %ax,%esi
80107724:	e8 bc d3 ff ff       	call   80104ae5 <cpuid>
80107729:	57                   	push   %edi
8010772a:	56                   	push   %esi
8010772b:	50                   	push   %eax
8010772c:	8d 83 54 d4 ff ff    	lea    -0x2bac(%ebx),%eax
80107732:	50                   	push   %eax
80107733:	e8 70 8d ff ff       	call   801004a8 <cprintf>
80107738:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010773b:	e8 6b bf ff ff       	call   801036ab <lapiceoi>
    break;
80107740:	e9 be 00 00 00       	jmp    80107803 <.L28+0x1>

80107745 <.L13>:

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80107745:	e8 5c d4 ff ff       	call   80104ba6 <myproc>
8010774a:	85 c0                	test   %eax,%eax
8010774c:	74 11                	je     8010775f <.L13+0x1a>
8010774e:	8b 45 08             	mov    0x8(%ebp),%eax
80107751:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107755:	0f b7 c0             	movzwl %ax,%eax
80107758:	83 e0 03             	and    $0x3,%eax
8010775b:	85 c0                	test   %eax,%eax
8010775d:	75 3d                	jne    8010779c <.L13+0x57>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010775f:	e8 ce fc ff ff       	call   80107432 <rcr2>
80107764:	89 c6                	mov    %eax,%esi
80107766:	8b 45 08             	mov    0x8(%ebp),%eax
80107769:	8b 78 38             	mov    0x38(%eax),%edi
8010776c:	e8 74 d3 ff ff       	call   80104ae5 <cpuid>
80107771:	8b 55 08             	mov    0x8(%ebp),%edx
80107774:	8b 52 30             	mov    0x30(%edx),%edx
80107777:	83 ec 0c             	sub    $0xc,%esp
8010777a:	56                   	push   %esi
8010777b:	57                   	push   %edi
8010777c:	50                   	push   %eax
8010777d:	52                   	push   %edx
8010777e:	8d 83 78 d4 ff ff    	lea    -0x2b88(%ebx),%eax
80107784:	50                   	push   %eax
80107785:	e8 1e 8d ff ff       	call   801004a8 <cprintf>
8010778a:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
8010778d:	83 ec 0c             	sub    $0xc,%esp
80107790:	8d 83 aa d4 ff ff    	lea    -0x2b56(%ebx),%eax
80107796:	50                   	push   %eax
80107797:	e8 d9 8e ff ff       	call   80100675 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010779c:	e8 91 fc ff ff       	call   80107432 <rcr2>
801077a1:	89 c7                	mov    %eax,%edi
801077a3:	8b 45 08             	mov    0x8(%ebp),%eax
801077a6:	8b 40 38             	mov    0x38(%eax),%eax
801077a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077ac:	e8 34 d3 ff ff       	call   80104ae5 <cpuid>
801077b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801077b4:	8b 45 08             	mov    0x8(%ebp),%eax
801077b7:	8b 48 34             	mov    0x34(%eax),%ecx
801077ba:	89 4d dc             	mov    %ecx,-0x24(%ebp)
801077bd:	8b 45 08             	mov    0x8(%ebp),%eax
801077c0:	8b 50 30             	mov    0x30(%eax),%edx
801077c3:	89 55 d8             	mov    %edx,-0x28(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801077c6:	e8 db d3 ff ff       	call   80104ba6 <myproc>
801077cb:	8d 70 6c             	lea    0x6c(%eax),%esi
801077ce:	e8 d3 d3 ff ff       	call   80104ba6 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801077d3:	8b 40 10             	mov    0x10(%eax),%eax
801077d6:	57                   	push   %edi
801077d7:	ff 75 e4             	push   -0x1c(%ebp)
801077da:	ff 75 e0             	push   -0x20(%ebp)
801077dd:	ff 75 dc             	push   -0x24(%ebp)
801077e0:	ff 75 d8             	push   -0x28(%ebp)
801077e3:	56                   	push   %esi
801077e4:	50                   	push   %eax
801077e5:	8d 83 b0 d4 ff ff    	lea    -0x2b50(%ebx),%eax
801077eb:	50                   	push   %eax
801077ec:	e8 b7 8c ff ff       	call   801004a8 <cprintf>
801077f1:	83 c4 20             	add    $0x20,%esp
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801077f4:	e8 ad d3 ff ff       	call   80104ba6 <myproc>
801077f9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80107800:	eb 01                	jmp    80107803 <.L28+0x1>

80107802 <.L28>:
    break;
80107802:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107803:	e8 9e d3 ff ff       	call   80104ba6 <myproc>
80107808:	85 c0                	test   %eax,%eax
8010780a:	74 23                	je     8010782f <.L28+0x2d>
8010780c:	e8 95 d3 ff ff       	call   80104ba6 <myproc>
80107811:	8b 40 24             	mov    0x24(%eax),%eax
80107814:	85 c0                	test   %eax,%eax
80107816:	74 17                	je     8010782f <.L28+0x2d>
80107818:	8b 45 08             	mov    0x8(%ebp),%eax
8010781b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010781f:	0f b7 c0             	movzwl %ax,%eax
80107822:	83 e0 03             	and    $0x3,%eax
80107825:	83 f8 03             	cmp    $0x3,%eax
80107828:	75 05                	jne    8010782f <.L28+0x2d>
    exit();
8010782a:	e8 57 d8 ff ff       	call   80105086 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010782f:	e8 72 d3 ff ff       	call   80104ba6 <myproc>
80107834:	85 c0                	test   %eax,%eax
80107836:	74 1d                	je     80107855 <.L28+0x53>
80107838:	e8 69 d3 ff ff       	call   80104ba6 <myproc>
8010783d:	8b 40 0c             	mov    0xc(%eax),%eax
80107840:	83 f8 04             	cmp    $0x4,%eax
80107843:	75 10                	jne    80107855 <.L28+0x53>
     tf->trapno == T_IRQ0+IRQ_TIMER)
80107845:	8b 45 08             	mov    0x8(%ebp),%eax
80107848:	8b 40 30             	mov    0x30(%eax),%eax
  if(myproc() && myproc()->state == RUNNING &&
8010784b:	83 f8 20             	cmp    $0x20,%eax
8010784e:	75 05                	jne    80107855 <.L28+0x53>
    yield();
80107850:	e8 42 dc ff ff       	call   80105497 <yield>

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107855:	e8 4c d3 ff ff       	call   80104ba6 <myproc>
8010785a:	85 c0                	test   %eax,%eax
8010785c:	74 26                	je     80107884 <.L28+0x82>
8010785e:	e8 43 d3 ff ff       	call   80104ba6 <myproc>
80107863:	8b 40 24             	mov    0x24(%eax),%eax
80107866:	85 c0                	test   %eax,%eax
80107868:	74 1a                	je     80107884 <.L28+0x82>
8010786a:	8b 45 08             	mov    0x8(%ebp),%eax
8010786d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107871:	0f b7 c0             	movzwl %ax,%eax
80107874:	83 e0 03             	and    $0x3,%eax
80107877:	83 f8 03             	cmp    $0x3,%eax
8010787a:	75 08                	jne    80107884 <.L28+0x82>
    exit();
8010787c:	e8 05 d8 ff ff       	call   80105086 <exit>
80107881:	eb 01                	jmp    80107884 <.L28+0x82>
    return;
80107883:	90                   	nop
}
80107884:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107887:	5b                   	pop    %ebx
80107888:	5e                   	pop    %esi
80107889:	5f                   	pop    %edi
8010788a:	5d                   	pop    %ebp
8010788b:	c3                   	ret    

8010788c <inb>:
{
8010788c:	55                   	push   %ebp
8010788d:	89 e5                	mov    %esp,%ebp
8010788f:	83 ec 14             	sub    $0x14,%esp
80107892:	e8 91 94 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107897:	05 29 4c 00 00       	add    $0x4c29,%eax
8010789c:	8b 45 08             	mov    0x8(%ebp),%eax
8010789f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801078a3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801078a7:	89 c2                	mov    %eax,%edx
801078a9:	ec                   	in     (%dx),%al
801078aa:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801078ad:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801078b1:	c9                   	leave  
801078b2:	c3                   	ret    

801078b3 <outb>:
{
801078b3:	55                   	push   %ebp
801078b4:	89 e5                	mov    %esp,%ebp
801078b6:	83 ec 08             	sub    $0x8,%esp
801078b9:	e8 6a 94 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
801078be:	05 02 4c 00 00       	add    $0x4c02,%eax
801078c3:	8b 45 08             	mov    0x8(%ebp),%eax
801078c6:	8b 55 0c             	mov    0xc(%ebp),%edx
801078c9:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801078cd:	89 d0                	mov    %edx,%eax
801078cf:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801078d2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801078d6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801078da:	ee                   	out    %al,(%dx)
}
801078db:	90                   	nop
801078dc:	c9                   	leave  
801078dd:	c3                   	ret    

801078de <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801078de:	55                   	push   %ebp
801078df:	89 e5                	mov    %esp,%ebp
801078e1:	53                   	push   %ebx
801078e2:	83 ec 14             	sub    $0x14,%esp
801078e5:	e8 9b 8a ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801078ea:	81 c3 d6 4b 00 00    	add    $0x4bd6,%ebx
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801078f0:	6a 00                	push   $0x0
801078f2:	68 fa 03 00 00       	push   $0x3fa
801078f7:	e8 b7 ff ff ff       	call   801078b3 <outb>
801078fc:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801078ff:	68 80 00 00 00       	push   $0x80
80107904:	68 fb 03 00 00       	push   $0x3fb
80107909:	e8 a5 ff ff ff       	call   801078b3 <outb>
8010790e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80107911:	6a 0c                	push   $0xc
80107913:	68 f8 03 00 00       	push   $0x3f8
80107918:	e8 96 ff ff ff       	call   801078b3 <outb>
8010791d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80107920:	6a 00                	push   $0x0
80107922:	68 f9 03 00 00       	push   $0x3f9
80107927:	e8 87 ff ff ff       	call   801078b3 <outb>
8010792c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
8010792f:	6a 03                	push   $0x3
80107931:	68 fb 03 00 00       	push   $0x3fb
80107936:	e8 78 ff ff ff       	call   801078b3 <outb>
8010793b:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
8010793e:	6a 00                	push   $0x0
80107940:	68 fc 03 00 00       	push   $0x3fc
80107945:	e8 69 ff ff ff       	call   801078b3 <outb>
8010794a:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
8010794d:	6a 01                	push   $0x1
8010794f:	68 f9 03 00 00       	push   $0x3f9
80107954:	e8 5a ff ff ff       	call   801078b3 <outb>
80107959:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010795c:	68 fd 03 00 00       	push   $0x3fd
80107961:	e8 26 ff ff ff       	call   8010788c <inb>
80107966:	83 c4 04             	add    $0x4,%esp
80107969:	3c ff                	cmp    $0xff,%al
8010796b:	74 63                	je     801079d0 <uartinit+0xf2>
    return;
  uart = 1;
8010796d:	c7 83 38 a0 00 00 01 	movl   $0x1,0xa038(%ebx)
80107974:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80107977:	68 fa 03 00 00       	push   $0x3fa
8010797c:	e8 0b ff ff ff       	call   8010788c <inb>
80107981:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80107984:	68 f8 03 00 00       	push   $0x3f8
80107989:	e8 fe fe ff ff       	call   8010788c <inb>
8010798e:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
80107991:	83 ec 08             	sub    $0x8,%esp
80107994:	6a 00                	push   $0x0
80107996:	6a 04                	push   $0x4
80107998:	e8 3a b7 ff ff       	call   801030d7 <ioapicenable>
8010799d:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801079a0:	8d 83 74 d5 ff ff    	lea    -0x2a8c(%ebx),%eax
801079a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801079a9:	eb 19                	jmp    801079c4 <uartinit+0xe6>
    uartputc(*p);
801079ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ae:	0f b6 00             	movzbl (%eax),%eax
801079b1:	0f be c0             	movsbl %al,%eax
801079b4:	83 ec 0c             	sub    $0xc,%esp
801079b7:	50                   	push   %eax
801079b8:	e8 19 00 00 00       	call   801079d6 <uartputc>
801079bd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801079c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801079c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c7:	0f b6 00             	movzbl (%eax),%eax
801079ca:	84 c0                	test   %al,%al
801079cc:	75 dd                	jne    801079ab <uartinit+0xcd>
801079ce:	eb 01                	jmp    801079d1 <uartinit+0xf3>
    return;
801079d0:	90                   	nop
}
801079d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801079d4:	c9                   	leave  
801079d5:	c3                   	ret    

801079d6 <uartputc>:

void
uartputc(int c)
{
801079d6:	55                   	push   %ebp
801079d7:	89 e5                	mov    %esp,%ebp
801079d9:	53                   	push   %ebx
801079da:	83 ec 14             	sub    $0x14,%esp
801079dd:	e8 a3 89 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801079e2:	81 c3 de 4a 00 00    	add    $0x4ade,%ebx
  int i;

  if(!uart)
801079e8:	8b 83 38 a0 00 00    	mov    0xa038(%ebx),%eax
801079ee:	85 c0                	test   %eax,%eax
801079f0:	74 53                	je     80107a45 <uartputc+0x6f>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801079f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801079f9:	eb 11                	jmp    80107a0c <uartputc+0x36>
    microdelay(10);
801079fb:	83 ec 0c             	sub    $0xc,%esp
801079fe:	6a 0a                	push   $0xa
80107a00:	e8 cc bc ff ff       	call   801036d1 <microdelay>
80107a05:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107a08:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107a0c:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107a10:	7f 1a                	jg     80107a2c <uartputc+0x56>
80107a12:	83 ec 0c             	sub    $0xc,%esp
80107a15:	68 fd 03 00 00       	push   $0x3fd
80107a1a:	e8 6d fe ff ff       	call   8010788c <inb>
80107a1f:	83 c4 10             	add    $0x10,%esp
80107a22:	0f b6 c0             	movzbl %al,%eax
80107a25:	83 e0 20             	and    $0x20,%eax
80107a28:	85 c0                	test   %eax,%eax
80107a2a:	74 cf                	je     801079fb <uartputc+0x25>
  outb(COM1+0, c);
80107a2c:	8b 45 08             	mov    0x8(%ebp),%eax
80107a2f:	0f b6 c0             	movzbl %al,%eax
80107a32:	83 ec 08             	sub    $0x8,%esp
80107a35:	50                   	push   %eax
80107a36:	68 f8 03 00 00       	push   $0x3f8
80107a3b:	e8 73 fe ff ff       	call   801078b3 <outb>
80107a40:	83 c4 10             	add    $0x10,%esp
80107a43:	eb 01                	jmp    80107a46 <uartputc+0x70>
    return;
80107a45:	90                   	nop
}
80107a46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a49:	c9                   	leave  
80107a4a:	c3                   	ret    

80107a4b <uartgetc>:

static int
uartgetc(void)
{
80107a4b:	55                   	push   %ebp
80107a4c:	89 e5                	mov    %esp,%ebp
80107a4e:	e8 d5 92 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107a53:	05 6d 4a 00 00       	add    $0x4a6d,%eax
  if(!uart)
80107a58:	8b 80 38 a0 00 00    	mov    0xa038(%eax),%eax
80107a5e:	85 c0                	test   %eax,%eax
80107a60:	75 07                	jne    80107a69 <uartgetc+0x1e>
    return -1;
80107a62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a67:	eb 2e                	jmp    80107a97 <uartgetc+0x4c>
  if(!(inb(COM1+5) & 0x01))
80107a69:	68 fd 03 00 00       	push   $0x3fd
80107a6e:	e8 19 fe ff ff       	call   8010788c <inb>
80107a73:	83 c4 04             	add    $0x4,%esp
80107a76:	0f b6 c0             	movzbl %al,%eax
80107a79:	83 e0 01             	and    $0x1,%eax
80107a7c:	85 c0                	test   %eax,%eax
80107a7e:	75 07                	jne    80107a87 <uartgetc+0x3c>
    return -1;
80107a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a85:	eb 10                	jmp    80107a97 <uartgetc+0x4c>
  return inb(COM1+0);
80107a87:	68 f8 03 00 00       	push   $0x3f8
80107a8c:	e8 fb fd ff ff       	call   8010788c <inb>
80107a91:	83 c4 04             	add    $0x4,%esp
80107a94:	0f b6 c0             	movzbl %al,%eax
}
80107a97:	c9                   	leave  
80107a98:	c3                   	ret    

80107a99 <uartintr>:

void
uartintr(void)
{
80107a99:	55                   	push   %ebp
80107a9a:	89 e5                	mov    %esp,%ebp
80107a9c:	53                   	push   %ebx
80107a9d:	83 ec 04             	sub    $0x4,%esp
80107aa0:	e8 83 92 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80107aa5:	05 1b 4a 00 00       	add    $0x4a1b,%eax
  consoleintr(uartgetc);
80107aaa:	83 ec 0c             	sub    $0xc,%esp
80107aad:	8d 90 8b b5 ff ff    	lea    -0x4a75(%eax),%edx
80107ab3:	52                   	push   %edx
80107ab4:	89 c3                	mov    %eax,%ebx
80107ab6:	e8 88 8e ff ff       	call   80100943 <consoleintr>
80107abb:	83 c4 10             	add    $0x10,%esp
}
80107abe:	90                   	nop
80107abf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107ac2:	c9                   	leave  
80107ac3:	c3                   	ret    

80107ac4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107ac4:	6a 00                	push   $0x0
  pushl $0
80107ac6:	6a 00                	push   $0x0
  jmp alltraps
80107ac8:	e9 0e f9 ff ff       	jmp    801073db <alltraps>

80107acd <vector1>:
.globl vector1
vector1:
  pushl $0
80107acd:	6a 00                	push   $0x0
  pushl $1
80107acf:	6a 01                	push   $0x1
  jmp alltraps
80107ad1:	e9 05 f9 ff ff       	jmp    801073db <alltraps>

80107ad6 <vector2>:
.globl vector2
vector2:
  pushl $0
80107ad6:	6a 00                	push   $0x0
  pushl $2
80107ad8:	6a 02                	push   $0x2
  jmp alltraps
80107ada:	e9 fc f8 ff ff       	jmp    801073db <alltraps>

80107adf <vector3>:
.globl vector3
vector3:
  pushl $0
80107adf:	6a 00                	push   $0x0
  pushl $3
80107ae1:	6a 03                	push   $0x3
  jmp alltraps
80107ae3:	e9 f3 f8 ff ff       	jmp    801073db <alltraps>

80107ae8 <vector4>:
.globl vector4
vector4:
  pushl $0
80107ae8:	6a 00                	push   $0x0
  pushl $4
80107aea:	6a 04                	push   $0x4
  jmp alltraps
80107aec:	e9 ea f8 ff ff       	jmp    801073db <alltraps>

80107af1 <vector5>:
.globl vector5
vector5:
  pushl $0
80107af1:	6a 00                	push   $0x0
  pushl $5
80107af3:	6a 05                	push   $0x5
  jmp alltraps
80107af5:	e9 e1 f8 ff ff       	jmp    801073db <alltraps>

80107afa <vector6>:
.globl vector6
vector6:
  pushl $0
80107afa:	6a 00                	push   $0x0
  pushl $6
80107afc:	6a 06                	push   $0x6
  jmp alltraps
80107afe:	e9 d8 f8 ff ff       	jmp    801073db <alltraps>

80107b03 <vector7>:
.globl vector7
vector7:
  pushl $0
80107b03:	6a 00                	push   $0x0
  pushl $7
80107b05:	6a 07                	push   $0x7
  jmp alltraps
80107b07:	e9 cf f8 ff ff       	jmp    801073db <alltraps>

80107b0c <vector8>:
.globl vector8
vector8:
  pushl $8
80107b0c:	6a 08                	push   $0x8
  jmp alltraps
80107b0e:	e9 c8 f8 ff ff       	jmp    801073db <alltraps>

80107b13 <vector9>:
.globl vector9
vector9:
  pushl $0
80107b13:	6a 00                	push   $0x0
  pushl $9
80107b15:	6a 09                	push   $0x9
  jmp alltraps
80107b17:	e9 bf f8 ff ff       	jmp    801073db <alltraps>

80107b1c <vector10>:
.globl vector10
vector10:
  pushl $10
80107b1c:	6a 0a                	push   $0xa
  jmp alltraps
80107b1e:	e9 b8 f8 ff ff       	jmp    801073db <alltraps>

80107b23 <vector11>:
.globl vector11
vector11:
  pushl $11
80107b23:	6a 0b                	push   $0xb
  jmp alltraps
80107b25:	e9 b1 f8 ff ff       	jmp    801073db <alltraps>

80107b2a <vector12>:
.globl vector12
vector12:
  pushl $12
80107b2a:	6a 0c                	push   $0xc
  jmp alltraps
80107b2c:	e9 aa f8 ff ff       	jmp    801073db <alltraps>

80107b31 <vector13>:
.globl vector13
vector13:
  pushl $13
80107b31:	6a 0d                	push   $0xd
  jmp alltraps
80107b33:	e9 a3 f8 ff ff       	jmp    801073db <alltraps>

80107b38 <vector14>:
.globl vector14
vector14:
  pushl $14
80107b38:	6a 0e                	push   $0xe
  jmp alltraps
80107b3a:	e9 9c f8 ff ff       	jmp    801073db <alltraps>

80107b3f <vector15>:
.globl vector15
vector15:
  pushl $0
80107b3f:	6a 00                	push   $0x0
  pushl $15
80107b41:	6a 0f                	push   $0xf
  jmp alltraps
80107b43:	e9 93 f8 ff ff       	jmp    801073db <alltraps>

80107b48 <vector16>:
.globl vector16
vector16:
  pushl $0
80107b48:	6a 00                	push   $0x0
  pushl $16
80107b4a:	6a 10                	push   $0x10
  jmp alltraps
80107b4c:	e9 8a f8 ff ff       	jmp    801073db <alltraps>

80107b51 <vector17>:
.globl vector17
vector17:
  pushl $17
80107b51:	6a 11                	push   $0x11
  jmp alltraps
80107b53:	e9 83 f8 ff ff       	jmp    801073db <alltraps>

80107b58 <vector18>:
.globl vector18
vector18:
  pushl $0
80107b58:	6a 00                	push   $0x0
  pushl $18
80107b5a:	6a 12                	push   $0x12
  jmp alltraps
80107b5c:	e9 7a f8 ff ff       	jmp    801073db <alltraps>

80107b61 <vector19>:
.globl vector19
vector19:
  pushl $0
80107b61:	6a 00                	push   $0x0
  pushl $19
80107b63:	6a 13                	push   $0x13
  jmp alltraps
80107b65:	e9 71 f8 ff ff       	jmp    801073db <alltraps>

80107b6a <vector20>:
.globl vector20
vector20:
  pushl $0
80107b6a:	6a 00                	push   $0x0
  pushl $20
80107b6c:	6a 14                	push   $0x14
  jmp alltraps
80107b6e:	e9 68 f8 ff ff       	jmp    801073db <alltraps>

80107b73 <vector21>:
.globl vector21
vector21:
  pushl $0
80107b73:	6a 00                	push   $0x0
  pushl $21
80107b75:	6a 15                	push   $0x15
  jmp alltraps
80107b77:	e9 5f f8 ff ff       	jmp    801073db <alltraps>

80107b7c <vector22>:
.globl vector22
vector22:
  pushl $0
80107b7c:	6a 00                	push   $0x0
  pushl $22
80107b7e:	6a 16                	push   $0x16
  jmp alltraps
80107b80:	e9 56 f8 ff ff       	jmp    801073db <alltraps>

80107b85 <vector23>:
.globl vector23
vector23:
  pushl $0
80107b85:	6a 00                	push   $0x0
  pushl $23
80107b87:	6a 17                	push   $0x17
  jmp alltraps
80107b89:	e9 4d f8 ff ff       	jmp    801073db <alltraps>

80107b8e <vector24>:
.globl vector24
vector24:
  pushl $0
80107b8e:	6a 00                	push   $0x0
  pushl $24
80107b90:	6a 18                	push   $0x18
  jmp alltraps
80107b92:	e9 44 f8 ff ff       	jmp    801073db <alltraps>

80107b97 <vector25>:
.globl vector25
vector25:
  pushl $0
80107b97:	6a 00                	push   $0x0
  pushl $25
80107b99:	6a 19                	push   $0x19
  jmp alltraps
80107b9b:	e9 3b f8 ff ff       	jmp    801073db <alltraps>

80107ba0 <vector26>:
.globl vector26
vector26:
  pushl $0
80107ba0:	6a 00                	push   $0x0
  pushl $26
80107ba2:	6a 1a                	push   $0x1a
  jmp alltraps
80107ba4:	e9 32 f8 ff ff       	jmp    801073db <alltraps>

80107ba9 <vector27>:
.globl vector27
vector27:
  pushl $0
80107ba9:	6a 00                	push   $0x0
  pushl $27
80107bab:	6a 1b                	push   $0x1b
  jmp alltraps
80107bad:	e9 29 f8 ff ff       	jmp    801073db <alltraps>

80107bb2 <vector28>:
.globl vector28
vector28:
  pushl $0
80107bb2:	6a 00                	push   $0x0
  pushl $28
80107bb4:	6a 1c                	push   $0x1c
  jmp alltraps
80107bb6:	e9 20 f8 ff ff       	jmp    801073db <alltraps>

80107bbb <vector29>:
.globl vector29
vector29:
  pushl $0
80107bbb:	6a 00                	push   $0x0
  pushl $29
80107bbd:	6a 1d                	push   $0x1d
  jmp alltraps
80107bbf:	e9 17 f8 ff ff       	jmp    801073db <alltraps>

80107bc4 <vector30>:
.globl vector30
vector30:
  pushl $0
80107bc4:	6a 00                	push   $0x0
  pushl $30
80107bc6:	6a 1e                	push   $0x1e
  jmp alltraps
80107bc8:	e9 0e f8 ff ff       	jmp    801073db <alltraps>

80107bcd <vector31>:
.globl vector31
vector31:
  pushl $0
80107bcd:	6a 00                	push   $0x0
  pushl $31
80107bcf:	6a 1f                	push   $0x1f
  jmp alltraps
80107bd1:	e9 05 f8 ff ff       	jmp    801073db <alltraps>

80107bd6 <vector32>:
.globl vector32
vector32:
  pushl $0
80107bd6:	6a 00                	push   $0x0
  pushl $32
80107bd8:	6a 20                	push   $0x20
  jmp alltraps
80107bda:	e9 fc f7 ff ff       	jmp    801073db <alltraps>

80107bdf <vector33>:
.globl vector33
vector33:
  pushl $0
80107bdf:	6a 00                	push   $0x0
  pushl $33
80107be1:	6a 21                	push   $0x21
  jmp alltraps
80107be3:	e9 f3 f7 ff ff       	jmp    801073db <alltraps>

80107be8 <vector34>:
.globl vector34
vector34:
  pushl $0
80107be8:	6a 00                	push   $0x0
  pushl $34
80107bea:	6a 22                	push   $0x22
  jmp alltraps
80107bec:	e9 ea f7 ff ff       	jmp    801073db <alltraps>

80107bf1 <vector35>:
.globl vector35
vector35:
  pushl $0
80107bf1:	6a 00                	push   $0x0
  pushl $35
80107bf3:	6a 23                	push   $0x23
  jmp alltraps
80107bf5:	e9 e1 f7 ff ff       	jmp    801073db <alltraps>

80107bfa <vector36>:
.globl vector36
vector36:
  pushl $0
80107bfa:	6a 00                	push   $0x0
  pushl $36
80107bfc:	6a 24                	push   $0x24
  jmp alltraps
80107bfe:	e9 d8 f7 ff ff       	jmp    801073db <alltraps>

80107c03 <vector37>:
.globl vector37
vector37:
  pushl $0
80107c03:	6a 00                	push   $0x0
  pushl $37
80107c05:	6a 25                	push   $0x25
  jmp alltraps
80107c07:	e9 cf f7 ff ff       	jmp    801073db <alltraps>

80107c0c <vector38>:
.globl vector38
vector38:
  pushl $0
80107c0c:	6a 00                	push   $0x0
  pushl $38
80107c0e:	6a 26                	push   $0x26
  jmp alltraps
80107c10:	e9 c6 f7 ff ff       	jmp    801073db <alltraps>

80107c15 <vector39>:
.globl vector39
vector39:
  pushl $0
80107c15:	6a 00                	push   $0x0
  pushl $39
80107c17:	6a 27                	push   $0x27
  jmp alltraps
80107c19:	e9 bd f7 ff ff       	jmp    801073db <alltraps>

80107c1e <vector40>:
.globl vector40
vector40:
  pushl $0
80107c1e:	6a 00                	push   $0x0
  pushl $40
80107c20:	6a 28                	push   $0x28
  jmp alltraps
80107c22:	e9 b4 f7 ff ff       	jmp    801073db <alltraps>

80107c27 <vector41>:
.globl vector41
vector41:
  pushl $0
80107c27:	6a 00                	push   $0x0
  pushl $41
80107c29:	6a 29                	push   $0x29
  jmp alltraps
80107c2b:	e9 ab f7 ff ff       	jmp    801073db <alltraps>

80107c30 <vector42>:
.globl vector42
vector42:
  pushl $0
80107c30:	6a 00                	push   $0x0
  pushl $42
80107c32:	6a 2a                	push   $0x2a
  jmp alltraps
80107c34:	e9 a2 f7 ff ff       	jmp    801073db <alltraps>

80107c39 <vector43>:
.globl vector43
vector43:
  pushl $0
80107c39:	6a 00                	push   $0x0
  pushl $43
80107c3b:	6a 2b                	push   $0x2b
  jmp alltraps
80107c3d:	e9 99 f7 ff ff       	jmp    801073db <alltraps>

80107c42 <vector44>:
.globl vector44
vector44:
  pushl $0
80107c42:	6a 00                	push   $0x0
  pushl $44
80107c44:	6a 2c                	push   $0x2c
  jmp alltraps
80107c46:	e9 90 f7 ff ff       	jmp    801073db <alltraps>

80107c4b <vector45>:
.globl vector45
vector45:
  pushl $0
80107c4b:	6a 00                	push   $0x0
  pushl $45
80107c4d:	6a 2d                	push   $0x2d
  jmp alltraps
80107c4f:	e9 87 f7 ff ff       	jmp    801073db <alltraps>

80107c54 <vector46>:
.globl vector46
vector46:
  pushl $0
80107c54:	6a 00                	push   $0x0
  pushl $46
80107c56:	6a 2e                	push   $0x2e
  jmp alltraps
80107c58:	e9 7e f7 ff ff       	jmp    801073db <alltraps>

80107c5d <vector47>:
.globl vector47
vector47:
  pushl $0
80107c5d:	6a 00                	push   $0x0
  pushl $47
80107c5f:	6a 2f                	push   $0x2f
  jmp alltraps
80107c61:	e9 75 f7 ff ff       	jmp    801073db <alltraps>

80107c66 <vector48>:
.globl vector48
vector48:
  pushl $0
80107c66:	6a 00                	push   $0x0
  pushl $48
80107c68:	6a 30                	push   $0x30
  jmp alltraps
80107c6a:	e9 6c f7 ff ff       	jmp    801073db <alltraps>

80107c6f <vector49>:
.globl vector49
vector49:
  pushl $0
80107c6f:	6a 00                	push   $0x0
  pushl $49
80107c71:	6a 31                	push   $0x31
  jmp alltraps
80107c73:	e9 63 f7 ff ff       	jmp    801073db <alltraps>

80107c78 <vector50>:
.globl vector50
vector50:
  pushl $0
80107c78:	6a 00                	push   $0x0
  pushl $50
80107c7a:	6a 32                	push   $0x32
  jmp alltraps
80107c7c:	e9 5a f7 ff ff       	jmp    801073db <alltraps>

80107c81 <vector51>:
.globl vector51
vector51:
  pushl $0
80107c81:	6a 00                	push   $0x0
  pushl $51
80107c83:	6a 33                	push   $0x33
  jmp alltraps
80107c85:	e9 51 f7 ff ff       	jmp    801073db <alltraps>

80107c8a <vector52>:
.globl vector52
vector52:
  pushl $0
80107c8a:	6a 00                	push   $0x0
  pushl $52
80107c8c:	6a 34                	push   $0x34
  jmp alltraps
80107c8e:	e9 48 f7 ff ff       	jmp    801073db <alltraps>

80107c93 <vector53>:
.globl vector53
vector53:
  pushl $0
80107c93:	6a 00                	push   $0x0
  pushl $53
80107c95:	6a 35                	push   $0x35
  jmp alltraps
80107c97:	e9 3f f7 ff ff       	jmp    801073db <alltraps>

80107c9c <vector54>:
.globl vector54
vector54:
  pushl $0
80107c9c:	6a 00                	push   $0x0
  pushl $54
80107c9e:	6a 36                	push   $0x36
  jmp alltraps
80107ca0:	e9 36 f7 ff ff       	jmp    801073db <alltraps>

80107ca5 <vector55>:
.globl vector55
vector55:
  pushl $0
80107ca5:	6a 00                	push   $0x0
  pushl $55
80107ca7:	6a 37                	push   $0x37
  jmp alltraps
80107ca9:	e9 2d f7 ff ff       	jmp    801073db <alltraps>

80107cae <vector56>:
.globl vector56
vector56:
  pushl $0
80107cae:	6a 00                	push   $0x0
  pushl $56
80107cb0:	6a 38                	push   $0x38
  jmp alltraps
80107cb2:	e9 24 f7 ff ff       	jmp    801073db <alltraps>

80107cb7 <vector57>:
.globl vector57
vector57:
  pushl $0
80107cb7:	6a 00                	push   $0x0
  pushl $57
80107cb9:	6a 39                	push   $0x39
  jmp alltraps
80107cbb:	e9 1b f7 ff ff       	jmp    801073db <alltraps>

80107cc0 <vector58>:
.globl vector58
vector58:
  pushl $0
80107cc0:	6a 00                	push   $0x0
  pushl $58
80107cc2:	6a 3a                	push   $0x3a
  jmp alltraps
80107cc4:	e9 12 f7 ff ff       	jmp    801073db <alltraps>

80107cc9 <vector59>:
.globl vector59
vector59:
  pushl $0
80107cc9:	6a 00                	push   $0x0
  pushl $59
80107ccb:	6a 3b                	push   $0x3b
  jmp alltraps
80107ccd:	e9 09 f7 ff ff       	jmp    801073db <alltraps>

80107cd2 <vector60>:
.globl vector60
vector60:
  pushl $0
80107cd2:	6a 00                	push   $0x0
  pushl $60
80107cd4:	6a 3c                	push   $0x3c
  jmp alltraps
80107cd6:	e9 00 f7 ff ff       	jmp    801073db <alltraps>

80107cdb <vector61>:
.globl vector61
vector61:
  pushl $0
80107cdb:	6a 00                	push   $0x0
  pushl $61
80107cdd:	6a 3d                	push   $0x3d
  jmp alltraps
80107cdf:	e9 f7 f6 ff ff       	jmp    801073db <alltraps>

80107ce4 <vector62>:
.globl vector62
vector62:
  pushl $0
80107ce4:	6a 00                	push   $0x0
  pushl $62
80107ce6:	6a 3e                	push   $0x3e
  jmp alltraps
80107ce8:	e9 ee f6 ff ff       	jmp    801073db <alltraps>

80107ced <vector63>:
.globl vector63
vector63:
  pushl $0
80107ced:	6a 00                	push   $0x0
  pushl $63
80107cef:	6a 3f                	push   $0x3f
  jmp alltraps
80107cf1:	e9 e5 f6 ff ff       	jmp    801073db <alltraps>

80107cf6 <vector64>:
.globl vector64
vector64:
  pushl $0
80107cf6:	6a 00                	push   $0x0
  pushl $64
80107cf8:	6a 40                	push   $0x40
  jmp alltraps
80107cfa:	e9 dc f6 ff ff       	jmp    801073db <alltraps>

80107cff <vector65>:
.globl vector65
vector65:
  pushl $0
80107cff:	6a 00                	push   $0x0
  pushl $65
80107d01:	6a 41                	push   $0x41
  jmp alltraps
80107d03:	e9 d3 f6 ff ff       	jmp    801073db <alltraps>

80107d08 <vector66>:
.globl vector66
vector66:
  pushl $0
80107d08:	6a 00                	push   $0x0
  pushl $66
80107d0a:	6a 42                	push   $0x42
  jmp alltraps
80107d0c:	e9 ca f6 ff ff       	jmp    801073db <alltraps>

80107d11 <vector67>:
.globl vector67
vector67:
  pushl $0
80107d11:	6a 00                	push   $0x0
  pushl $67
80107d13:	6a 43                	push   $0x43
  jmp alltraps
80107d15:	e9 c1 f6 ff ff       	jmp    801073db <alltraps>

80107d1a <vector68>:
.globl vector68
vector68:
  pushl $0
80107d1a:	6a 00                	push   $0x0
  pushl $68
80107d1c:	6a 44                	push   $0x44
  jmp alltraps
80107d1e:	e9 b8 f6 ff ff       	jmp    801073db <alltraps>

80107d23 <vector69>:
.globl vector69
vector69:
  pushl $0
80107d23:	6a 00                	push   $0x0
  pushl $69
80107d25:	6a 45                	push   $0x45
  jmp alltraps
80107d27:	e9 af f6 ff ff       	jmp    801073db <alltraps>

80107d2c <vector70>:
.globl vector70
vector70:
  pushl $0
80107d2c:	6a 00                	push   $0x0
  pushl $70
80107d2e:	6a 46                	push   $0x46
  jmp alltraps
80107d30:	e9 a6 f6 ff ff       	jmp    801073db <alltraps>

80107d35 <vector71>:
.globl vector71
vector71:
  pushl $0
80107d35:	6a 00                	push   $0x0
  pushl $71
80107d37:	6a 47                	push   $0x47
  jmp alltraps
80107d39:	e9 9d f6 ff ff       	jmp    801073db <alltraps>

80107d3e <vector72>:
.globl vector72
vector72:
  pushl $0
80107d3e:	6a 00                	push   $0x0
  pushl $72
80107d40:	6a 48                	push   $0x48
  jmp alltraps
80107d42:	e9 94 f6 ff ff       	jmp    801073db <alltraps>

80107d47 <vector73>:
.globl vector73
vector73:
  pushl $0
80107d47:	6a 00                	push   $0x0
  pushl $73
80107d49:	6a 49                	push   $0x49
  jmp alltraps
80107d4b:	e9 8b f6 ff ff       	jmp    801073db <alltraps>

80107d50 <vector74>:
.globl vector74
vector74:
  pushl $0
80107d50:	6a 00                	push   $0x0
  pushl $74
80107d52:	6a 4a                	push   $0x4a
  jmp alltraps
80107d54:	e9 82 f6 ff ff       	jmp    801073db <alltraps>

80107d59 <vector75>:
.globl vector75
vector75:
  pushl $0
80107d59:	6a 00                	push   $0x0
  pushl $75
80107d5b:	6a 4b                	push   $0x4b
  jmp alltraps
80107d5d:	e9 79 f6 ff ff       	jmp    801073db <alltraps>

80107d62 <vector76>:
.globl vector76
vector76:
  pushl $0
80107d62:	6a 00                	push   $0x0
  pushl $76
80107d64:	6a 4c                	push   $0x4c
  jmp alltraps
80107d66:	e9 70 f6 ff ff       	jmp    801073db <alltraps>

80107d6b <vector77>:
.globl vector77
vector77:
  pushl $0
80107d6b:	6a 00                	push   $0x0
  pushl $77
80107d6d:	6a 4d                	push   $0x4d
  jmp alltraps
80107d6f:	e9 67 f6 ff ff       	jmp    801073db <alltraps>

80107d74 <vector78>:
.globl vector78
vector78:
  pushl $0
80107d74:	6a 00                	push   $0x0
  pushl $78
80107d76:	6a 4e                	push   $0x4e
  jmp alltraps
80107d78:	e9 5e f6 ff ff       	jmp    801073db <alltraps>

80107d7d <vector79>:
.globl vector79
vector79:
  pushl $0
80107d7d:	6a 00                	push   $0x0
  pushl $79
80107d7f:	6a 4f                	push   $0x4f
  jmp alltraps
80107d81:	e9 55 f6 ff ff       	jmp    801073db <alltraps>

80107d86 <vector80>:
.globl vector80
vector80:
  pushl $0
80107d86:	6a 00                	push   $0x0
  pushl $80
80107d88:	6a 50                	push   $0x50
  jmp alltraps
80107d8a:	e9 4c f6 ff ff       	jmp    801073db <alltraps>

80107d8f <vector81>:
.globl vector81
vector81:
  pushl $0
80107d8f:	6a 00                	push   $0x0
  pushl $81
80107d91:	6a 51                	push   $0x51
  jmp alltraps
80107d93:	e9 43 f6 ff ff       	jmp    801073db <alltraps>

80107d98 <vector82>:
.globl vector82
vector82:
  pushl $0
80107d98:	6a 00                	push   $0x0
  pushl $82
80107d9a:	6a 52                	push   $0x52
  jmp alltraps
80107d9c:	e9 3a f6 ff ff       	jmp    801073db <alltraps>

80107da1 <vector83>:
.globl vector83
vector83:
  pushl $0
80107da1:	6a 00                	push   $0x0
  pushl $83
80107da3:	6a 53                	push   $0x53
  jmp alltraps
80107da5:	e9 31 f6 ff ff       	jmp    801073db <alltraps>

80107daa <vector84>:
.globl vector84
vector84:
  pushl $0
80107daa:	6a 00                	push   $0x0
  pushl $84
80107dac:	6a 54                	push   $0x54
  jmp alltraps
80107dae:	e9 28 f6 ff ff       	jmp    801073db <alltraps>

80107db3 <vector85>:
.globl vector85
vector85:
  pushl $0
80107db3:	6a 00                	push   $0x0
  pushl $85
80107db5:	6a 55                	push   $0x55
  jmp alltraps
80107db7:	e9 1f f6 ff ff       	jmp    801073db <alltraps>

80107dbc <vector86>:
.globl vector86
vector86:
  pushl $0
80107dbc:	6a 00                	push   $0x0
  pushl $86
80107dbe:	6a 56                	push   $0x56
  jmp alltraps
80107dc0:	e9 16 f6 ff ff       	jmp    801073db <alltraps>

80107dc5 <vector87>:
.globl vector87
vector87:
  pushl $0
80107dc5:	6a 00                	push   $0x0
  pushl $87
80107dc7:	6a 57                	push   $0x57
  jmp alltraps
80107dc9:	e9 0d f6 ff ff       	jmp    801073db <alltraps>

80107dce <vector88>:
.globl vector88
vector88:
  pushl $0
80107dce:	6a 00                	push   $0x0
  pushl $88
80107dd0:	6a 58                	push   $0x58
  jmp alltraps
80107dd2:	e9 04 f6 ff ff       	jmp    801073db <alltraps>

80107dd7 <vector89>:
.globl vector89
vector89:
  pushl $0
80107dd7:	6a 00                	push   $0x0
  pushl $89
80107dd9:	6a 59                	push   $0x59
  jmp alltraps
80107ddb:	e9 fb f5 ff ff       	jmp    801073db <alltraps>

80107de0 <vector90>:
.globl vector90
vector90:
  pushl $0
80107de0:	6a 00                	push   $0x0
  pushl $90
80107de2:	6a 5a                	push   $0x5a
  jmp alltraps
80107de4:	e9 f2 f5 ff ff       	jmp    801073db <alltraps>

80107de9 <vector91>:
.globl vector91
vector91:
  pushl $0
80107de9:	6a 00                	push   $0x0
  pushl $91
80107deb:	6a 5b                	push   $0x5b
  jmp alltraps
80107ded:	e9 e9 f5 ff ff       	jmp    801073db <alltraps>

80107df2 <vector92>:
.globl vector92
vector92:
  pushl $0
80107df2:	6a 00                	push   $0x0
  pushl $92
80107df4:	6a 5c                	push   $0x5c
  jmp alltraps
80107df6:	e9 e0 f5 ff ff       	jmp    801073db <alltraps>

80107dfb <vector93>:
.globl vector93
vector93:
  pushl $0
80107dfb:	6a 00                	push   $0x0
  pushl $93
80107dfd:	6a 5d                	push   $0x5d
  jmp alltraps
80107dff:	e9 d7 f5 ff ff       	jmp    801073db <alltraps>

80107e04 <vector94>:
.globl vector94
vector94:
  pushl $0
80107e04:	6a 00                	push   $0x0
  pushl $94
80107e06:	6a 5e                	push   $0x5e
  jmp alltraps
80107e08:	e9 ce f5 ff ff       	jmp    801073db <alltraps>

80107e0d <vector95>:
.globl vector95
vector95:
  pushl $0
80107e0d:	6a 00                	push   $0x0
  pushl $95
80107e0f:	6a 5f                	push   $0x5f
  jmp alltraps
80107e11:	e9 c5 f5 ff ff       	jmp    801073db <alltraps>

80107e16 <vector96>:
.globl vector96
vector96:
  pushl $0
80107e16:	6a 00                	push   $0x0
  pushl $96
80107e18:	6a 60                	push   $0x60
  jmp alltraps
80107e1a:	e9 bc f5 ff ff       	jmp    801073db <alltraps>

80107e1f <vector97>:
.globl vector97
vector97:
  pushl $0
80107e1f:	6a 00                	push   $0x0
  pushl $97
80107e21:	6a 61                	push   $0x61
  jmp alltraps
80107e23:	e9 b3 f5 ff ff       	jmp    801073db <alltraps>

80107e28 <vector98>:
.globl vector98
vector98:
  pushl $0
80107e28:	6a 00                	push   $0x0
  pushl $98
80107e2a:	6a 62                	push   $0x62
  jmp alltraps
80107e2c:	e9 aa f5 ff ff       	jmp    801073db <alltraps>

80107e31 <vector99>:
.globl vector99
vector99:
  pushl $0
80107e31:	6a 00                	push   $0x0
  pushl $99
80107e33:	6a 63                	push   $0x63
  jmp alltraps
80107e35:	e9 a1 f5 ff ff       	jmp    801073db <alltraps>

80107e3a <vector100>:
.globl vector100
vector100:
  pushl $0
80107e3a:	6a 00                	push   $0x0
  pushl $100
80107e3c:	6a 64                	push   $0x64
  jmp alltraps
80107e3e:	e9 98 f5 ff ff       	jmp    801073db <alltraps>

80107e43 <vector101>:
.globl vector101
vector101:
  pushl $0
80107e43:	6a 00                	push   $0x0
  pushl $101
80107e45:	6a 65                	push   $0x65
  jmp alltraps
80107e47:	e9 8f f5 ff ff       	jmp    801073db <alltraps>

80107e4c <vector102>:
.globl vector102
vector102:
  pushl $0
80107e4c:	6a 00                	push   $0x0
  pushl $102
80107e4e:	6a 66                	push   $0x66
  jmp alltraps
80107e50:	e9 86 f5 ff ff       	jmp    801073db <alltraps>

80107e55 <vector103>:
.globl vector103
vector103:
  pushl $0
80107e55:	6a 00                	push   $0x0
  pushl $103
80107e57:	6a 67                	push   $0x67
  jmp alltraps
80107e59:	e9 7d f5 ff ff       	jmp    801073db <alltraps>

80107e5e <vector104>:
.globl vector104
vector104:
  pushl $0
80107e5e:	6a 00                	push   $0x0
  pushl $104
80107e60:	6a 68                	push   $0x68
  jmp alltraps
80107e62:	e9 74 f5 ff ff       	jmp    801073db <alltraps>

80107e67 <vector105>:
.globl vector105
vector105:
  pushl $0
80107e67:	6a 00                	push   $0x0
  pushl $105
80107e69:	6a 69                	push   $0x69
  jmp alltraps
80107e6b:	e9 6b f5 ff ff       	jmp    801073db <alltraps>

80107e70 <vector106>:
.globl vector106
vector106:
  pushl $0
80107e70:	6a 00                	push   $0x0
  pushl $106
80107e72:	6a 6a                	push   $0x6a
  jmp alltraps
80107e74:	e9 62 f5 ff ff       	jmp    801073db <alltraps>

80107e79 <vector107>:
.globl vector107
vector107:
  pushl $0
80107e79:	6a 00                	push   $0x0
  pushl $107
80107e7b:	6a 6b                	push   $0x6b
  jmp alltraps
80107e7d:	e9 59 f5 ff ff       	jmp    801073db <alltraps>

80107e82 <vector108>:
.globl vector108
vector108:
  pushl $0
80107e82:	6a 00                	push   $0x0
  pushl $108
80107e84:	6a 6c                	push   $0x6c
  jmp alltraps
80107e86:	e9 50 f5 ff ff       	jmp    801073db <alltraps>

80107e8b <vector109>:
.globl vector109
vector109:
  pushl $0
80107e8b:	6a 00                	push   $0x0
  pushl $109
80107e8d:	6a 6d                	push   $0x6d
  jmp alltraps
80107e8f:	e9 47 f5 ff ff       	jmp    801073db <alltraps>

80107e94 <vector110>:
.globl vector110
vector110:
  pushl $0
80107e94:	6a 00                	push   $0x0
  pushl $110
80107e96:	6a 6e                	push   $0x6e
  jmp alltraps
80107e98:	e9 3e f5 ff ff       	jmp    801073db <alltraps>

80107e9d <vector111>:
.globl vector111
vector111:
  pushl $0
80107e9d:	6a 00                	push   $0x0
  pushl $111
80107e9f:	6a 6f                	push   $0x6f
  jmp alltraps
80107ea1:	e9 35 f5 ff ff       	jmp    801073db <alltraps>

80107ea6 <vector112>:
.globl vector112
vector112:
  pushl $0
80107ea6:	6a 00                	push   $0x0
  pushl $112
80107ea8:	6a 70                	push   $0x70
  jmp alltraps
80107eaa:	e9 2c f5 ff ff       	jmp    801073db <alltraps>

80107eaf <vector113>:
.globl vector113
vector113:
  pushl $0
80107eaf:	6a 00                	push   $0x0
  pushl $113
80107eb1:	6a 71                	push   $0x71
  jmp alltraps
80107eb3:	e9 23 f5 ff ff       	jmp    801073db <alltraps>

80107eb8 <vector114>:
.globl vector114
vector114:
  pushl $0
80107eb8:	6a 00                	push   $0x0
  pushl $114
80107eba:	6a 72                	push   $0x72
  jmp alltraps
80107ebc:	e9 1a f5 ff ff       	jmp    801073db <alltraps>

80107ec1 <vector115>:
.globl vector115
vector115:
  pushl $0
80107ec1:	6a 00                	push   $0x0
  pushl $115
80107ec3:	6a 73                	push   $0x73
  jmp alltraps
80107ec5:	e9 11 f5 ff ff       	jmp    801073db <alltraps>

80107eca <vector116>:
.globl vector116
vector116:
  pushl $0
80107eca:	6a 00                	push   $0x0
  pushl $116
80107ecc:	6a 74                	push   $0x74
  jmp alltraps
80107ece:	e9 08 f5 ff ff       	jmp    801073db <alltraps>

80107ed3 <vector117>:
.globl vector117
vector117:
  pushl $0
80107ed3:	6a 00                	push   $0x0
  pushl $117
80107ed5:	6a 75                	push   $0x75
  jmp alltraps
80107ed7:	e9 ff f4 ff ff       	jmp    801073db <alltraps>

80107edc <vector118>:
.globl vector118
vector118:
  pushl $0
80107edc:	6a 00                	push   $0x0
  pushl $118
80107ede:	6a 76                	push   $0x76
  jmp alltraps
80107ee0:	e9 f6 f4 ff ff       	jmp    801073db <alltraps>

80107ee5 <vector119>:
.globl vector119
vector119:
  pushl $0
80107ee5:	6a 00                	push   $0x0
  pushl $119
80107ee7:	6a 77                	push   $0x77
  jmp alltraps
80107ee9:	e9 ed f4 ff ff       	jmp    801073db <alltraps>

80107eee <vector120>:
.globl vector120
vector120:
  pushl $0
80107eee:	6a 00                	push   $0x0
  pushl $120
80107ef0:	6a 78                	push   $0x78
  jmp alltraps
80107ef2:	e9 e4 f4 ff ff       	jmp    801073db <alltraps>

80107ef7 <vector121>:
.globl vector121
vector121:
  pushl $0
80107ef7:	6a 00                	push   $0x0
  pushl $121
80107ef9:	6a 79                	push   $0x79
  jmp alltraps
80107efb:	e9 db f4 ff ff       	jmp    801073db <alltraps>

80107f00 <vector122>:
.globl vector122
vector122:
  pushl $0
80107f00:	6a 00                	push   $0x0
  pushl $122
80107f02:	6a 7a                	push   $0x7a
  jmp alltraps
80107f04:	e9 d2 f4 ff ff       	jmp    801073db <alltraps>

80107f09 <vector123>:
.globl vector123
vector123:
  pushl $0
80107f09:	6a 00                	push   $0x0
  pushl $123
80107f0b:	6a 7b                	push   $0x7b
  jmp alltraps
80107f0d:	e9 c9 f4 ff ff       	jmp    801073db <alltraps>

80107f12 <vector124>:
.globl vector124
vector124:
  pushl $0
80107f12:	6a 00                	push   $0x0
  pushl $124
80107f14:	6a 7c                	push   $0x7c
  jmp alltraps
80107f16:	e9 c0 f4 ff ff       	jmp    801073db <alltraps>

80107f1b <vector125>:
.globl vector125
vector125:
  pushl $0
80107f1b:	6a 00                	push   $0x0
  pushl $125
80107f1d:	6a 7d                	push   $0x7d
  jmp alltraps
80107f1f:	e9 b7 f4 ff ff       	jmp    801073db <alltraps>

80107f24 <vector126>:
.globl vector126
vector126:
  pushl $0
80107f24:	6a 00                	push   $0x0
  pushl $126
80107f26:	6a 7e                	push   $0x7e
  jmp alltraps
80107f28:	e9 ae f4 ff ff       	jmp    801073db <alltraps>

80107f2d <vector127>:
.globl vector127
vector127:
  pushl $0
80107f2d:	6a 00                	push   $0x0
  pushl $127
80107f2f:	6a 7f                	push   $0x7f
  jmp alltraps
80107f31:	e9 a5 f4 ff ff       	jmp    801073db <alltraps>

80107f36 <vector128>:
.globl vector128
vector128:
  pushl $0
80107f36:	6a 00                	push   $0x0
  pushl $128
80107f38:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107f3d:	e9 99 f4 ff ff       	jmp    801073db <alltraps>

80107f42 <vector129>:
.globl vector129
vector129:
  pushl $0
80107f42:	6a 00                	push   $0x0
  pushl $129
80107f44:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107f49:	e9 8d f4 ff ff       	jmp    801073db <alltraps>

80107f4e <vector130>:
.globl vector130
vector130:
  pushl $0
80107f4e:	6a 00                	push   $0x0
  pushl $130
80107f50:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107f55:	e9 81 f4 ff ff       	jmp    801073db <alltraps>

80107f5a <vector131>:
.globl vector131
vector131:
  pushl $0
80107f5a:	6a 00                	push   $0x0
  pushl $131
80107f5c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107f61:	e9 75 f4 ff ff       	jmp    801073db <alltraps>

80107f66 <vector132>:
.globl vector132
vector132:
  pushl $0
80107f66:	6a 00                	push   $0x0
  pushl $132
80107f68:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107f6d:	e9 69 f4 ff ff       	jmp    801073db <alltraps>

80107f72 <vector133>:
.globl vector133
vector133:
  pushl $0
80107f72:	6a 00                	push   $0x0
  pushl $133
80107f74:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80107f79:	e9 5d f4 ff ff       	jmp    801073db <alltraps>

80107f7e <vector134>:
.globl vector134
vector134:
  pushl $0
80107f7e:	6a 00                	push   $0x0
  pushl $134
80107f80:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107f85:	e9 51 f4 ff ff       	jmp    801073db <alltraps>

80107f8a <vector135>:
.globl vector135
vector135:
  pushl $0
80107f8a:	6a 00                	push   $0x0
  pushl $135
80107f8c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107f91:	e9 45 f4 ff ff       	jmp    801073db <alltraps>

80107f96 <vector136>:
.globl vector136
vector136:
  pushl $0
80107f96:	6a 00                	push   $0x0
  pushl $136
80107f98:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107f9d:	e9 39 f4 ff ff       	jmp    801073db <alltraps>

80107fa2 <vector137>:
.globl vector137
vector137:
  pushl $0
80107fa2:	6a 00                	push   $0x0
  pushl $137
80107fa4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107fa9:	e9 2d f4 ff ff       	jmp    801073db <alltraps>

80107fae <vector138>:
.globl vector138
vector138:
  pushl $0
80107fae:	6a 00                	push   $0x0
  pushl $138
80107fb0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107fb5:	e9 21 f4 ff ff       	jmp    801073db <alltraps>

80107fba <vector139>:
.globl vector139
vector139:
  pushl $0
80107fba:	6a 00                	push   $0x0
  pushl $139
80107fbc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107fc1:	e9 15 f4 ff ff       	jmp    801073db <alltraps>

80107fc6 <vector140>:
.globl vector140
vector140:
  pushl $0
80107fc6:	6a 00                	push   $0x0
  pushl $140
80107fc8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107fcd:	e9 09 f4 ff ff       	jmp    801073db <alltraps>

80107fd2 <vector141>:
.globl vector141
vector141:
  pushl $0
80107fd2:	6a 00                	push   $0x0
  pushl $141
80107fd4:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107fd9:	e9 fd f3 ff ff       	jmp    801073db <alltraps>

80107fde <vector142>:
.globl vector142
vector142:
  pushl $0
80107fde:	6a 00                	push   $0x0
  pushl $142
80107fe0:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107fe5:	e9 f1 f3 ff ff       	jmp    801073db <alltraps>

80107fea <vector143>:
.globl vector143
vector143:
  pushl $0
80107fea:	6a 00                	push   $0x0
  pushl $143
80107fec:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107ff1:	e9 e5 f3 ff ff       	jmp    801073db <alltraps>

80107ff6 <vector144>:
.globl vector144
vector144:
  pushl $0
80107ff6:	6a 00                	push   $0x0
  pushl $144
80107ff8:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107ffd:	e9 d9 f3 ff ff       	jmp    801073db <alltraps>

80108002 <vector145>:
.globl vector145
vector145:
  pushl $0
80108002:	6a 00                	push   $0x0
  pushl $145
80108004:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80108009:	e9 cd f3 ff ff       	jmp    801073db <alltraps>

8010800e <vector146>:
.globl vector146
vector146:
  pushl $0
8010800e:	6a 00                	push   $0x0
  pushl $146
80108010:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108015:	e9 c1 f3 ff ff       	jmp    801073db <alltraps>

8010801a <vector147>:
.globl vector147
vector147:
  pushl $0
8010801a:	6a 00                	push   $0x0
  pushl $147
8010801c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108021:	e9 b5 f3 ff ff       	jmp    801073db <alltraps>

80108026 <vector148>:
.globl vector148
vector148:
  pushl $0
80108026:	6a 00                	push   $0x0
  pushl $148
80108028:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010802d:	e9 a9 f3 ff ff       	jmp    801073db <alltraps>

80108032 <vector149>:
.globl vector149
vector149:
  pushl $0
80108032:	6a 00                	push   $0x0
  pushl $149
80108034:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80108039:	e9 9d f3 ff ff       	jmp    801073db <alltraps>

8010803e <vector150>:
.globl vector150
vector150:
  pushl $0
8010803e:	6a 00                	push   $0x0
  pushl $150
80108040:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108045:	e9 91 f3 ff ff       	jmp    801073db <alltraps>

8010804a <vector151>:
.globl vector151
vector151:
  pushl $0
8010804a:	6a 00                	push   $0x0
  pushl $151
8010804c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108051:	e9 85 f3 ff ff       	jmp    801073db <alltraps>

80108056 <vector152>:
.globl vector152
vector152:
  pushl $0
80108056:	6a 00                	push   $0x0
  pushl $152
80108058:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010805d:	e9 79 f3 ff ff       	jmp    801073db <alltraps>

80108062 <vector153>:
.globl vector153
vector153:
  pushl $0
80108062:	6a 00                	push   $0x0
  pushl $153
80108064:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80108069:	e9 6d f3 ff ff       	jmp    801073db <alltraps>

8010806e <vector154>:
.globl vector154
vector154:
  pushl $0
8010806e:	6a 00                	push   $0x0
  pushl $154
80108070:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80108075:	e9 61 f3 ff ff       	jmp    801073db <alltraps>

8010807a <vector155>:
.globl vector155
vector155:
  pushl $0
8010807a:	6a 00                	push   $0x0
  pushl $155
8010807c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80108081:	e9 55 f3 ff ff       	jmp    801073db <alltraps>

80108086 <vector156>:
.globl vector156
vector156:
  pushl $0
80108086:	6a 00                	push   $0x0
  pushl $156
80108088:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010808d:	e9 49 f3 ff ff       	jmp    801073db <alltraps>

80108092 <vector157>:
.globl vector157
vector157:
  pushl $0
80108092:	6a 00                	push   $0x0
  pushl $157
80108094:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80108099:	e9 3d f3 ff ff       	jmp    801073db <alltraps>

8010809e <vector158>:
.globl vector158
vector158:
  pushl $0
8010809e:	6a 00                	push   $0x0
  pushl $158
801080a0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801080a5:	e9 31 f3 ff ff       	jmp    801073db <alltraps>

801080aa <vector159>:
.globl vector159
vector159:
  pushl $0
801080aa:	6a 00                	push   $0x0
  pushl $159
801080ac:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801080b1:	e9 25 f3 ff ff       	jmp    801073db <alltraps>

801080b6 <vector160>:
.globl vector160
vector160:
  pushl $0
801080b6:	6a 00                	push   $0x0
  pushl $160
801080b8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801080bd:	e9 19 f3 ff ff       	jmp    801073db <alltraps>

801080c2 <vector161>:
.globl vector161
vector161:
  pushl $0
801080c2:	6a 00                	push   $0x0
  pushl $161
801080c4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801080c9:	e9 0d f3 ff ff       	jmp    801073db <alltraps>

801080ce <vector162>:
.globl vector162
vector162:
  pushl $0
801080ce:	6a 00                	push   $0x0
  pushl $162
801080d0:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801080d5:	e9 01 f3 ff ff       	jmp    801073db <alltraps>

801080da <vector163>:
.globl vector163
vector163:
  pushl $0
801080da:	6a 00                	push   $0x0
  pushl $163
801080dc:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801080e1:	e9 f5 f2 ff ff       	jmp    801073db <alltraps>

801080e6 <vector164>:
.globl vector164
vector164:
  pushl $0
801080e6:	6a 00                	push   $0x0
  pushl $164
801080e8:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801080ed:	e9 e9 f2 ff ff       	jmp    801073db <alltraps>

801080f2 <vector165>:
.globl vector165
vector165:
  pushl $0
801080f2:	6a 00                	push   $0x0
  pushl $165
801080f4:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801080f9:	e9 dd f2 ff ff       	jmp    801073db <alltraps>

801080fe <vector166>:
.globl vector166
vector166:
  pushl $0
801080fe:	6a 00                	push   $0x0
  pushl $166
80108100:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80108105:	e9 d1 f2 ff ff       	jmp    801073db <alltraps>

8010810a <vector167>:
.globl vector167
vector167:
  pushl $0
8010810a:	6a 00                	push   $0x0
  pushl $167
8010810c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108111:	e9 c5 f2 ff ff       	jmp    801073db <alltraps>

80108116 <vector168>:
.globl vector168
vector168:
  pushl $0
80108116:	6a 00                	push   $0x0
  pushl $168
80108118:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010811d:	e9 b9 f2 ff ff       	jmp    801073db <alltraps>

80108122 <vector169>:
.globl vector169
vector169:
  pushl $0
80108122:	6a 00                	push   $0x0
  pushl $169
80108124:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80108129:	e9 ad f2 ff ff       	jmp    801073db <alltraps>

8010812e <vector170>:
.globl vector170
vector170:
  pushl $0
8010812e:	6a 00                	push   $0x0
  pushl $170
80108130:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108135:	e9 a1 f2 ff ff       	jmp    801073db <alltraps>

8010813a <vector171>:
.globl vector171
vector171:
  pushl $0
8010813a:	6a 00                	push   $0x0
  pushl $171
8010813c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108141:	e9 95 f2 ff ff       	jmp    801073db <alltraps>

80108146 <vector172>:
.globl vector172
vector172:
  pushl $0
80108146:	6a 00                	push   $0x0
  pushl $172
80108148:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010814d:	e9 89 f2 ff ff       	jmp    801073db <alltraps>

80108152 <vector173>:
.globl vector173
vector173:
  pushl $0
80108152:	6a 00                	push   $0x0
  pushl $173
80108154:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80108159:	e9 7d f2 ff ff       	jmp    801073db <alltraps>

8010815e <vector174>:
.globl vector174
vector174:
  pushl $0
8010815e:	6a 00                	push   $0x0
  pushl $174
80108160:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80108165:	e9 71 f2 ff ff       	jmp    801073db <alltraps>

8010816a <vector175>:
.globl vector175
vector175:
  pushl $0
8010816a:	6a 00                	push   $0x0
  pushl $175
8010816c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108171:	e9 65 f2 ff ff       	jmp    801073db <alltraps>

80108176 <vector176>:
.globl vector176
vector176:
  pushl $0
80108176:	6a 00                	push   $0x0
  pushl $176
80108178:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010817d:	e9 59 f2 ff ff       	jmp    801073db <alltraps>

80108182 <vector177>:
.globl vector177
vector177:
  pushl $0
80108182:	6a 00                	push   $0x0
  pushl $177
80108184:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80108189:	e9 4d f2 ff ff       	jmp    801073db <alltraps>

8010818e <vector178>:
.globl vector178
vector178:
  pushl $0
8010818e:	6a 00                	push   $0x0
  pushl $178
80108190:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80108195:	e9 41 f2 ff ff       	jmp    801073db <alltraps>

8010819a <vector179>:
.globl vector179
vector179:
  pushl $0
8010819a:	6a 00                	push   $0x0
  pushl $179
8010819c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801081a1:	e9 35 f2 ff ff       	jmp    801073db <alltraps>

801081a6 <vector180>:
.globl vector180
vector180:
  pushl $0
801081a6:	6a 00                	push   $0x0
  pushl $180
801081a8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801081ad:	e9 29 f2 ff ff       	jmp    801073db <alltraps>

801081b2 <vector181>:
.globl vector181
vector181:
  pushl $0
801081b2:	6a 00                	push   $0x0
  pushl $181
801081b4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801081b9:	e9 1d f2 ff ff       	jmp    801073db <alltraps>

801081be <vector182>:
.globl vector182
vector182:
  pushl $0
801081be:	6a 00                	push   $0x0
  pushl $182
801081c0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801081c5:	e9 11 f2 ff ff       	jmp    801073db <alltraps>

801081ca <vector183>:
.globl vector183
vector183:
  pushl $0
801081ca:	6a 00                	push   $0x0
  pushl $183
801081cc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801081d1:	e9 05 f2 ff ff       	jmp    801073db <alltraps>

801081d6 <vector184>:
.globl vector184
vector184:
  pushl $0
801081d6:	6a 00                	push   $0x0
  pushl $184
801081d8:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801081dd:	e9 f9 f1 ff ff       	jmp    801073db <alltraps>

801081e2 <vector185>:
.globl vector185
vector185:
  pushl $0
801081e2:	6a 00                	push   $0x0
  pushl $185
801081e4:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801081e9:	e9 ed f1 ff ff       	jmp    801073db <alltraps>

801081ee <vector186>:
.globl vector186
vector186:
  pushl $0
801081ee:	6a 00                	push   $0x0
  pushl $186
801081f0:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801081f5:	e9 e1 f1 ff ff       	jmp    801073db <alltraps>

801081fa <vector187>:
.globl vector187
vector187:
  pushl $0
801081fa:	6a 00                	push   $0x0
  pushl $187
801081fc:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108201:	e9 d5 f1 ff ff       	jmp    801073db <alltraps>

80108206 <vector188>:
.globl vector188
vector188:
  pushl $0
80108206:	6a 00                	push   $0x0
  pushl $188
80108208:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010820d:	e9 c9 f1 ff ff       	jmp    801073db <alltraps>

80108212 <vector189>:
.globl vector189
vector189:
  pushl $0
80108212:	6a 00                	push   $0x0
  pushl $189
80108214:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80108219:	e9 bd f1 ff ff       	jmp    801073db <alltraps>

8010821e <vector190>:
.globl vector190
vector190:
  pushl $0
8010821e:	6a 00                	push   $0x0
  pushl $190
80108220:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108225:	e9 b1 f1 ff ff       	jmp    801073db <alltraps>

8010822a <vector191>:
.globl vector191
vector191:
  pushl $0
8010822a:	6a 00                	push   $0x0
  pushl $191
8010822c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108231:	e9 a5 f1 ff ff       	jmp    801073db <alltraps>

80108236 <vector192>:
.globl vector192
vector192:
  pushl $0
80108236:	6a 00                	push   $0x0
  pushl $192
80108238:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010823d:	e9 99 f1 ff ff       	jmp    801073db <alltraps>

80108242 <vector193>:
.globl vector193
vector193:
  pushl $0
80108242:	6a 00                	push   $0x0
  pushl $193
80108244:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80108249:	e9 8d f1 ff ff       	jmp    801073db <alltraps>

8010824e <vector194>:
.globl vector194
vector194:
  pushl $0
8010824e:	6a 00                	push   $0x0
  pushl $194
80108250:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108255:	e9 81 f1 ff ff       	jmp    801073db <alltraps>

8010825a <vector195>:
.globl vector195
vector195:
  pushl $0
8010825a:	6a 00                	push   $0x0
  pushl $195
8010825c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80108261:	e9 75 f1 ff ff       	jmp    801073db <alltraps>

80108266 <vector196>:
.globl vector196
vector196:
  pushl $0
80108266:	6a 00                	push   $0x0
  pushl $196
80108268:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010826d:	e9 69 f1 ff ff       	jmp    801073db <alltraps>

80108272 <vector197>:
.globl vector197
vector197:
  pushl $0
80108272:	6a 00                	push   $0x0
  pushl $197
80108274:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80108279:	e9 5d f1 ff ff       	jmp    801073db <alltraps>

8010827e <vector198>:
.globl vector198
vector198:
  pushl $0
8010827e:	6a 00                	push   $0x0
  pushl $198
80108280:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80108285:	e9 51 f1 ff ff       	jmp    801073db <alltraps>

8010828a <vector199>:
.globl vector199
vector199:
  pushl $0
8010828a:	6a 00                	push   $0x0
  pushl $199
8010828c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80108291:	e9 45 f1 ff ff       	jmp    801073db <alltraps>

80108296 <vector200>:
.globl vector200
vector200:
  pushl $0
80108296:	6a 00                	push   $0x0
  pushl $200
80108298:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010829d:	e9 39 f1 ff ff       	jmp    801073db <alltraps>

801082a2 <vector201>:
.globl vector201
vector201:
  pushl $0
801082a2:	6a 00                	push   $0x0
  pushl $201
801082a4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801082a9:	e9 2d f1 ff ff       	jmp    801073db <alltraps>

801082ae <vector202>:
.globl vector202
vector202:
  pushl $0
801082ae:	6a 00                	push   $0x0
  pushl $202
801082b0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801082b5:	e9 21 f1 ff ff       	jmp    801073db <alltraps>

801082ba <vector203>:
.globl vector203
vector203:
  pushl $0
801082ba:	6a 00                	push   $0x0
  pushl $203
801082bc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801082c1:	e9 15 f1 ff ff       	jmp    801073db <alltraps>

801082c6 <vector204>:
.globl vector204
vector204:
  pushl $0
801082c6:	6a 00                	push   $0x0
  pushl $204
801082c8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801082cd:	e9 09 f1 ff ff       	jmp    801073db <alltraps>

801082d2 <vector205>:
.globl vector205
vector205:
  pushl $0
801082d2:	6a 00                	push   $0x0
  pushl $205
801082d4:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801082d9:	e9 fd f0 ff ff       	jmp    801073db <alltraps>

801082de <vector206>:
.globl vector206
vector206:
  pushl $0
801082de:	6a 00                	push   $0x0
  pushl $206
801082e0:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801082e5:	e9 f1 f0 ff ff       	jmp    801073db <alltraps>

801082ea <vector207>:
.globl vector207
vector207:
  pushl $0
801082ea:	6a 00                	push   $0x0
  pushl $207
801082ec:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801082f1:	e9 e5 f0 ff ff       	jmp    801073db <alltraps>

801082f6 <vector208>:
.globl vector208
vector208:
  pushl $0
801082f6:	6a 00                	push   $0x0
  pushl $208
801082f8:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801082fd:	e9 d9 f0 ff ff       	jmp    801073db <alltraps>

80108302 <vector209>:
.globl vector209
vector209:
  pushl $0
80108302:	6a 00                	push   $0x0
  pushl $209
80108304:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80108309:	e9 cd f0 ff ff       	jmp    801073db <alltraps>

8010830e <vector210>:
.globl vector210
vector210:
  pushl $0
8010830e:	6a 00                	push   $0x0
  pushl $210
80108310:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108315:	e9 c1 f0 ff ff       	jmp    801073db <alltraps>

8010831a <vector211>:
.globl vector211
vector211:
  pushl $0
8010831a:	6a 00                	push   $0x0
  pushl $211
8010831c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108321:	e9 b5 f0 ff ff       	jmp    801073db <alltraps>

80108326 <vector212>:
.globl vector212
vector212:
  pushl $0
80108326:	6a 00                	push   $0x0
  pushl $212
80108328:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010832d:	e9 a9 f0 ff ff       	jmp    801073db <alltraps>

80108332 <vector213>:
.globl vector213
vector213:
  pushl $0
80108332:	6a 00                	push   $0x0
  pushl $213
80108334:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80108339:	e9 9d f0 ff ff       	jmp    801073db <alltraps>

8010833e <vector214>:
.globl vector214
vector214:
  pushl $0
8010833e:	6a 00                	push   $0x0
  pushl $214
80108340:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108345:	e9 91 f0 ff ff       	jmp    801073db <alltraps>

8010834a <vector215>:
.globl vector215
vector215:
  pushl $0
8010834a:	6a 00                	push   $0x0
  pushl $215
8010834c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108351:	e9 85 f0 ff ff       	jmp    801073db <alltraps>

80108356 <vector216>:
.globl vector216
vector216:
  pushl $0
80108356:	6a 00                	push   $0x0
  pushl $216
80108358:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010835d:	e9 79 f0 ff ff       	jmp    801073db <alltraps>

80108362 <vector217>:
.globl vector217
vector217:
  pushl $0
80108362:	6a 00                	push   $0x0
  pushl $217
80108364:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80108369:	e9 6d f0 ff ff       	jmp    801073db <alltraps>

8010836e <vector218>:
.globl vector218
vector218:
  pushl $0
8010836e:	6a 00                	push   $0x0
  pushl $218
80108370:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80108375:	e9 61 f0 ff ff       	jmp    801073db <alltraps>

8010837a <vector219>:
.globl vector219
vector219:
  pushl $0
8010837a:	6a 00                	push   $0x0
  pushl $219
8010837c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80108381:	e9 55 f0 ff ff       	jmp    801073db <alltraps>

80108386 <vector220>:
.globl vector220
vector220:
  pushl $0
80108386:	6a 00                	push   $0x0
  pushl $220
80108388:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010838d:	e9 49 f0 ff ff       	jmp    801073db <alltraps>

80108392 <vector221>:
.globl vector221
vector221:
  pushl $0
80108392:	6a 00                	push   $0x0
  pushl $221
80108394:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80108399:	e9 3d f0 ff ff       	jmp    801073db <alltraps>

8010839e <vector222>:
.globl vector222
vector222:
  pushl $0
8010839e:	6a 00                	push   $0x0
  pushl $222
801083a0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801083a5:	e9 31 f0 ff ff       	jmp    801073db <alltraps>

801083aa <vector223>:
.globl vector223
vector223:
  pushl $0
801083aa:	6a 00                	push   $0x0
  pushl $223
801083ac:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801083b1:	e9 25 f0 ff ff       	jmp    801073db <alltraps>

801083b6 <vector224>:
.globl vector224
vector224:
  pushl $0
801083b6:	6a 00                	push   $0x0
  pushl $224
801083b8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801083bd:	e9 19 f0 ff ff       	jmp    801073db <alltraps>

801083c2 <vector225>:
.globl vector225
vector225:
  pushl $0
801083c2:	6a 00                	push   $0x0
  pushl $225
801083c4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801083c9:	e9 0d f0 ff ff       	jmp    801073db <alltraps>

801083ce <vector226>:
.globl vector226
vector226:
  pushl $0
801083ce:	6a 00                	push   $0x0
  pushl $226
801083d0:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801083d5:	e9 01 f0 ff ff       	jmp    801073db <alltraps>

801083da <vector227>:
.globl vector227
vector227:
  pushl $0
801083da:	6a 00                	push   $0x0
  pushl $227
801083dc:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801083e1:	e9 f5 ef ff ff       	jmp    801073db <alltraps>

801083e6 <vector228>:
.globl vector228
vector228:
  pushl $0
801083e6:	6a 00                	push   $0x0
  pushl $228
801083e8:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801083ed:	e9 e9 ef ff ff       	jmp    801073db <alltraps>

801083f2 <vector229>:
.globl vector229
vector229:
  pushl $0
801083f2:	6a 00                	push   $0x0
  pushl $229
801083f4:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801083f9:	e9 dd ef ff ff       	jmp    801073db <alltraps>

801083fe <vector230>:
.globl vector230
vector230:
  pushl $0
801083fe:	6a 00                	push   $0x0
  pushl $230
80108400:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108405:	e9 d1 ef ff ff       	jmp    801073db <alltraps>

8010840a <vector231>:
.globl vector231
vector231:
  pushl $0
8010840a:	6a 00                	push   $0x0
  pushl $231
8010840c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108411:	e9 c5 ef ff ff       	jmp    801073db <alltraps>

80108416 <vector232>:
.globl vector232
vector232:
  pushl $0
80108416:	6a 00                	push   $0x0
  pushl $232
80108418:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010841d:	e9 b9 ef ff ff       	jmp    801073db <alltraps>

80108422 <vector233>:
.globl vector233
vector233:
  pushl $0
80108422:	6a 00                	push   $0x0
  pushl $233
80108424:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80108429:	e9 ad ef ff ff       	jmp    801073db <alltraps>

8010842e <vector234>:
.globl vector234
vector234:
  pushl $0
8010842e:	6a 00                	push   $0x0
  pushl $234
80108430:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108435:	e9 a1 ef ff ff       	jmp    801073db <alltraps>

8010843a <vector235>:
.globl vector235
vector235:
  pushl $0
8010843a:	6a 00                	push   $0x0
  pushl $235
8010843c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108441:	e9 95 ef ff ff       	jmp    801073db <alltraps>

80108446 <vector236>:
.globl vector236
vector236:
  pushl $0
80108446:	6a 00                	push   $0x0
  pushl $236
80108448:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010844d:	e9 89 ef ff ff       	jmp    801073db <alltraps>

80108452 <vector237>:
.globl vector237
vector237:
  pushl $0
80108452:	6a 00                	push   $0x0
  pushl $237
80108454:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80108459:	e9 7d ef ff ff       	jmp    801073db <alltraps>

8010845e <vector238>:
.globl vector238
vector238:
  pushl $0
8010845e:	6a 00                	push   $0x0
  pushl $238
80108460:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108465:	e9 71 ef ff ff       	jmp    801073db <alltraps>

8010846a <vector239>:
.globl vector239
vector239:
  pushl $0
8010846a:	6a 00                	push   $0x0
  pushl $239
8010846c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108471:	e9 65 ef ff ff       	jmp    801073db <alltraps>

80108476 <vector240>:
.globl vector240
vector240:
  pushl $0
80108476:	6a 00                	push   $0x0
  pushl $240
80108478:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010847d:	e9 59 ef ff ff       	jmp    801073db <alltraps>

80108482 <vector241>:
.globl vector241
vector241:
  pushl $0
80108482:	6a 00                	push   $0x0
  pushl $241
80108484:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80108489:	e9 4d ef ff ff       	jmp    801073db <alltraps>

8010848e <vector242>:
.globl vector242
vector242:
  pushl $0
8010848e:	6a 00                	push   $0x0
  pushl $242
80108490:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80108495:	e9 41 ef ff ff       	jmp    801073db <alltraps>

8010849a <vector243>:
.globl vector243
vector243:
  pushl $0
8010849a:	6a 00                	push   $0x0
  pushl $243
8010849c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801084a1:	e9 35 ef ff ff       	jmp    801073db <alltraps>

801084a6 <vector244>:
.globl vector244
vector244:
  pushl $0
801084a6:	6a 00                	push   $0x0
  pushl $244
801084a8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801084ad:	e9 29 ef ff ff       	jmp    801073db <alltraps>

801084b2 <vector245>:
.globl vector245
vector245:
  pushl $0
801084b2:	6a 00                	push   $0x0
  pushl $245
801084b4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801084b9:	e9 1d ef ff ff       	jmp    801073db <alltraps>

801084be <vector246>:
.globl vector246
vector246:
  pushl $0
801084be:	6a 00                	push   $0x0
  pushl $246
801084c0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801084c5:	e9 11 ef ff ff       	jmp    801073db <alltraps>

801084ca <vector247>:
.globl vector247
vector247:
  pushl $0
801084ca:	6a 00                	push   $0x0
  pushl $247
801084cc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801084d1:	e9 05 ef ff ff       	jmp    801073db <alltraps>

801084d6 <vector248>:
.globl vector248
vector248:
  pushl $0
801084d6:	6a 00                	push   $0x0
  pushl $248
801084d8:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801084dd:	e9 f9 ee ff ff       	jmp    801073db <alltraps>

801084e2 <vector249>:
.globl vector249
vector249:
  pushl $0
801084e2:	6a 00                	push   $0x0
  pushl $249
801084e4:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801084e9:	e9 ed ee ff ff       	jmp    801073db <alltraps>

801084ee <vector250>:
.globl vector250
vector250:
  pushl $0
801084ee:	6a 00                	push   $0x0
  pushl $250
801084f0:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801084f5:	e9 e1 ee ff ff       	jmp    801073db <alltraps>

801084fa <vector251>:
.globl vector251
vector251:
  pushl $0
801084fa:	6a 00                	push   $0x0
  pushl $251
801084fc:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108501:	e9 d5 ee ff ff       	jmp    801073db <alltraps>

80108506 <vector252>:
.globl vector252
vector252:
  pushl $0
80108506:	6a 00                	push   $0x0
  pushl $252
80108508:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010850d:	e9 c9 ee ff ff       	jmp    801073db <alltraps>

80108512 <vector253>:
.globl vector253
vector253:
  pushl $0
80108512:	6a 00                	push   $0x0
  pushl $253
80108514:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108519:	e9 bd ee ff ff       	jmp    801073db <alltraps>

8010851e <vector254>:
.globl vector254
vector254:
  pushl $0
8010851e:	6a 00                	push   $0x0
  pushl $254
80108520:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108525:	e9 b1 ee ff ff       	jmp    801073db <alltraps>

8010852a <vector255>:
.globl vector255
vector255:
  pushl $0
8010852a:	6a 00                	push   $0x0
  pushl $255
8010852c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108531:	e9 a5 ee ff ff       	jmp    801073db <alltraps>

80108536 <lgdt>:
{
80108536:	55                   	push   %ebp
80108537:	89 e5                	mov    %esp,%ebp
80108539:	83 ec 10             	sub    $0x10,%esp
8010853c:	e8 e7 87 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80108541:	05 7f 3f 00 00       	add    $0x3f7f,%eax
  pd[0] = size-1;
80108546:	8b 45 0c             	mov    0xc(%ebp),%eax
80108549:	83 e8 01             	sub    $0x1,%eax
8010854c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80108550:	8b 45 08             	mov    0x8(%ebp),%eax
80108553:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80108557:	8b 45 08             	mov    0x8(%ebp),%eax
8010855a:	c1 e8 10             	shr    $0x10,%eax
8010855d:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80108561:	8d 45 fa             	lea    -0x6(%ebp),%eax
80108564:	0f 01 10             	lgdtl  (%eax)
}
80108567:	90                   	nop
80108568:	c9                   	leave  
80108569:	c3                   	ret    

8010856a <ltr>:
{
8010856a:	55                   	push   %ebp
8010856b:	89 e5                	mov    %esp,%ebp
8010856d:	83 ec 04             	sub    $0x4,%esp
80108570:	e8 b3 87 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80108575:	05 4b 3f 00 00       	add    $0x3f4b,%eax
8010857a:	8b 45 08             	mov    0x8(%ebp),%eax
8010857d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80108581:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108585:	0f 00 d8             	ltr    %ax
}
80108588:	90                   	nop
80108589:	c9                   	leave  
8010858a:	c3                   	ret    

8010858b <lcr3>:

static inline void
lcr3(uint val)
{
8010858b:	55                   	push   %ebp
8010858c:	89 e5                	mov    %esp,%ebp
8010858e:	e8 95 87 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80108593:	05 2d 3f 00 00       	add    $0x3f2d,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108598:	8b 45 08             	mov    0x8(%ebp),%eax
8010859b:	0f 22 d8             	mov    %eax,%cr3
}
8010859e:	90                   	nop
8010859f:	5d                   	pop    %ebp
801085a0:	c3                   	ret    

801085a1 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801085a1:	55                   	push   %ebp
801085a2:	89 e5                	mov    %esp,%ebp
801085a4:	53                   	push   %ebx
801085a5:	83 ec 14             	sub    $0x14,%esp
801085a8:	e8 d8 7d ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801085ad:	81 c3 13 3f 00 00    	add    $0x3f13,%ebx

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801085b3:	e8 2d c5 ff ff       	call   80104ae5 <cpuid>
801085b8:	69 d0 b0 00 00 00    	imul   $0xb0,%eax,%edx
801085be:	c7 c0 e0 37 11 80    	mov    $0x801137e0,%eax
801085c4:	01 d0                	add    %edx,%eax
801085c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801085c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085cc:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801085d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d5:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801085db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085de:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801085e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e5:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801085e9:	83 e2 f0             	and    $0xfffffff0,%edx
801085ec:	83 ca 0a             	or     $0xa,%edx
801085ef:	88 50 7d             	mov    %dl,0x7d(%eax)
801085f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085f5:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801085f9:	83 ca 10             	or     $0x10,%edx
801085fc:	88 50 7d             	mov    %dl,0x7d(%eax)
801085ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108602:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80108606:	83 e2 9f             	and    $0xffffff9f,%edx
80108609:	88 50 7d             	mov    %dl,0x7d(%eax)
8010860c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010860f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80108613:	83 ca 80             	or     $0xffffff80,%edx
80108616:	88 50 7d             	mov    %dl,0x7d(%eax)
80108619:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010861c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108620:	83 ca 0f             	or     $0xf,%edx
80108623:	88 50 7e             	mov    %dl,0x7e(%eax)
80108626:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108629:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010862d:	83 e2 ef             	and    $0xffffffef,%edx
80108630:	88 50 7e             	mov    %dl,0x7e(%eax)
80108633:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108636:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010863a:	83 e2 df             	and    $0xffffffdf,%edx
8010863d:	88 50 7e             	mov    %dl,0x7e(%eax)
80108640:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108643:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108647:	83 ca 40             	or     $0x40,%edx
8010864a:	88 50 7e             	mov    %dl,0x7e(%eax)
8010864d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108650:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108654:	83 ca 80             	or     $0xffffff80,%edx
80108657:	88 50 7e             	mov    %dl,0x7e(%eax)
8010865a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010865d:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80108661:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108664:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
8010866b:	ff ff 
8010866d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108670:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80108677:	00 00 
80108679:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010867c:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80108683:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108686:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010868d:	83 e2 f0             	and    $0xfffffff0,%edx
80108690:	83 ca 02             	or     $0x2,%edx
80108693:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108699:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010869c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086a3:	83 ca 10             	or     $0x10,%edx
801086a6:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086af:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086b6:	83 e2 9f             	and    $0xffffff9f,%edx
801086b9:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086c2:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801086c9:	83 ca 80             	or     $0xffffff80,%edx
801086cc:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801086d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086d5:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801086dc:	83 ca 0f             	or     $0xf,%edx
801086df:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801086e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086e8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801086ef:	83 e2 ef             	and    $0xffffffef,%edx
801086f2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801086f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801086fb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108702:	83 e2 df             	and    $0xffffffdf,%edx
80108705:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010870b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010870e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108715:	83 ca 40             	or     $0x40,%edx
80108718:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010871e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108721:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108728:	83 ca 80             	or     $0xffffff80,%edx
8010872b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108731:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108734:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010873b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010873e:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80108745:	ff ff 
80108747:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010874a:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
80108751:	00 00 
80108753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108756:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
8010875d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108760:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108767:	83 e2 f0             	and    $0xfffffff0,%edx
8010876a:	83 ca 0a             	or     $0xa,%edx
8010876d:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108776:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010877d:	83 ca 10             	or     $0x10,%edx
80108780:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108786:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108789:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108790:	83 ca 60             	or     $0x60,%edx
80108793:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108799:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010879c:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
801087a3:	83 ca 80             	or     $0xffffff80,%edx
801087a6:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
801087ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087af:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801087b6:	83 ca 0f             	or     $0xf,%edx
801087b9:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801087bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087c2:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801087c9:	83 e2 ef             	and    $0xffffffef,%edx
801087cc:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801087d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087d5:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801087dc:	83 e2 df             	and    $0xffffffdf,%edx
801087df:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801087e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087e8:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801087ef:	83 ca 40             	or     $0x40,%edx
801087f2:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801087f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087fb:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108802:	83 ca 80             	or     $0xffffff80,%edx
80108805:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010880b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010880e:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108818:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010881f:	ff ff 
80108821:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108824:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010882b:	00 00 
8010882d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108830:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80108837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108841:	83 e2 f0             	and    $0xfffffff0,%edx
80108844:	83 ca 02             	or     $0x2,%edx
80108847:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010884d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108850:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108857:	83 ca 10             	or     $0x10,%edx
8010885a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108860:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108863:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010886a:	83 ca 60             	or     $0x60,%edx
8010886d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108873:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108876:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010887d:	83 ca 80             	or     $0xffffff80,%edx
80108880:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108886:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108889:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108890:	83 ca 0f             	or     $0xf,%edx
80108893:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010889c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801088a3:	83 e2 ef             	and    $0xffffffef,%edx
801088a6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801088ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088af:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801088b6:	83 e2 df             	and    $0xffffffdf,%edx
801088b9:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801088bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088c2:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801088c9:	83 ca 40             	or     $0x40,%edx
801088cc:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801088d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088d5:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801088dc:	83 ca 80             	or     $0xffffff80,%edx
801088df:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801088e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088e8:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801088ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088f2:	83 c0 70             	add    $0x70,%eax
801088f5:	83 ec 08             	sub    $0x8,%esp
801088f8:	6a 30                	push   $0x30
801088fa:	50                   	push   %eax
801088fb:	e8 36 fc ff ff       	call   80108536 <lgdt>
80108900:	83 c4 10             	add    $0x10,%esp
}
80108903:	90                   	nop
80108904:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108907:	c9                   	leave  
80108908:	c3                   	ret    

80108909 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108909:	55                   	push   %ebp
8010890a:	89 e5                	mov    %esp,%ebp
8010890c:	53                   	push   %ebx
8010890d:	83 ec 14             	sub    $0x14,%esp
80108910:	e8 70 7a ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108915:	81 c3 ab 3b 00 00    	add    $0x3bab,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010891b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010891e:	c1 e8 16             	shr    $0x16,%eax
80108921:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108928:	8b 45 08             	mov    0x8(%ebp),%eax
8010892b:	01 d0                	add    %edx,%eax
8010892d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80108930:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108933:	8b 00                	mov    (%eax),%eax
80108935:	83 e0 01             	and    $0x1,%eax
80108938:	85 c0                	test   %eax,%eax
8010893a:	74 14                	je     80108950 <walkpgdir+0x47>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010893c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010893f:	8b 00                	mov    (%eax),%eax
80108941:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108946:	05 00 00 00 80       	add    $0x80000000,%eax
8010894b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010894e:	eb 42                	jmp    80108992 <walkpgdir+0x89>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108950:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108954:	74 0e                	je     80108964 <walkpgdir+0x5b>
80108956:	e8 3e a9 ff ff       	call   80103299 <kalloc>
8010895b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010895e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108962:	75 07                	jne    8010896b <walkpgdir+0x62>
      return 0;
80108964:	b8 00 00 00 00       	mov    $0x0,%eax
80108969:	eb 3e                	jmp    801089a9 <walkpgdir+0xa0>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010896b:	83 ec 04             	sub    $0x4,%esp
8010896e:	68 00 10 00 00       	push   $0x1000
80108973:	6a 00                	push   $0x0
80108975:	ff 75 f4             	push   -0xc(%ebp)
80108978:	e8 77 d4 ff ff       	call   80105df4 <memset>
8010897d:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108980:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108983:	05 00 00 00 80       	add    $0x80000000,%eax
80108988:	83 c8 07             	or     $0x7,%eax
8010898b:	89 c2                	mov    %eax,%edx
8010898d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108990:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80108992:	8b 45 0c             	mov    0xc(%ebp),%eax
80108995:	c1 e8 0c             	shr    $0xc,%eax
80108998:	25 ff 03 00 00       	and    $0x3ff,%eax
8010899d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801089a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089a7:	01 d0                	add    %edx,%eax
}
801089a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801089ac:	c9                   	leave  
801089ad:	c3                   	ret    

801089ae <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801089ae:	55                   	push   %ebp
801089af:	89 e5                	mov    %esp,%ebp
801089b1:	53                   	push   %ebx
801089b2:	83 ec 14             	sub    $0x14,%esp
801089b5:	e8 cb 79 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801089ba:	81 c3 06 3b 00 00    	add    $0x3b06,%ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801089c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801089c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801089c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801089cb:	8b 55 0c             	mov    0xc(%ebp),%edx
801089ce:	8b 45 10             	mov    0x10(%ebp),%eax
801089d1:	01 d0                	add    %edx,%eax
801089d3:	83 e8 01             	sub    $0x1,%eax
801089d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801089db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801089de:	83 ec 04             	sub    $0x4,%esp
801089e1:	6a 01                	push   $0x1
801089e3:	ff 75 f4             	push   -0xc(%ebp)
801089e6:	ff 75 08             	push   0x8(%ebp)
801089e9:	e8 1b ff ff ff       	call   80108909 <walkpgdir>
801089ee:	83 c4 10             	add    $0x10,%esp
801089f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
801089f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801089f8:	75 07                	jne    80108a01 <mappages+0x53>
      return -1;
801089fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801089ff:	eb 49                	jmp    80108a4a <mappages+0x9c>
    if(*pte & PTE_P)
80108a01:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108a04:	8b 00                	mov    (%eax),%eax
80108a06:	83 e0 01             	and    $0x1,%eax
80108a09:	85 c0                	test   %eax,%eax
80108a0b:	74 0f                	je     80108a1c <mappages+0x6e>
      panic("remap");
80108a0d:	83 ec 0c             	sub    $0xc,%esp
80108a10:	8d 83 7c d5 ff ff    	lea    -0x2a84(%ebx),%eax
80108a16:	50                   	push   %eax
80108a17:	e8 59 7c ff ff       	call   80100675 <panic>
    *pte = pa | perm | PTE_P;
80108a1c:	8b 45 18             	mov    0x18(%ebp),%eax
80108a1f:	0b 45 14             	or     0x14(%ebp),%eax
80108a22:	83 c8 01             	or     $0x1,%eax
80108a25:	89 c2                	mov    %eax,%edx
80108a27:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108a2a:	89 10                	mov    %edx,(%eax)
    if(a == last)
80108a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108a32:	74 10                	je     80108a44 <mappages+0x96>
      break;
    a += PGSIZE;
80108a34:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80108a3b:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108a42:	eb 9a                	jmp    801089de <mappages+0x30>
      break;
80108a44:	90                   	nop
  }
  return 0;
80108a45:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108a4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108a4d:	c9                   	leave  
80108a4e:	c3                   	ret    

80108a4f <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108a4f:	55                   	push   %ebp
80108a50:	89 e5                	mov    %esp,%ebp
80108a52:	56                   	push   %esi
80108a53:	53                   	push   %ebx
80108a54:	83 ec 10             	sub    $0x10,%esp
80108a57:	e8 29 79 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108a5c:	81 c3 64 3a 00 00    	add    $0x3a64,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108a62:	e8 32 a8 ff ff       	call   80103299 <kalloc>
80108a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108a6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108a6e:	75 07                	jne    80108a77 <setupkvm+0x28>
    return 0;
80108a70:	b8 00 00 00 00       	mov    $0x0,%eax
80108a75:	eb 7c                	jmp    80108af3 <setupkvm+0xa4>
  memset(pgdir, 0, PGSIZE);
80108a77:	83 ec 04             	sub    $0x4,%esp
80108a7a:	68 00 10 00 00       	push   $0x1000
80108a7f:	6a 00                	push   $0x0
80108a81:	ff 75 f0             	push   -0x10(%ebp)
80108a84:	e8 6b d3 ff ff       	call   80105df4 <memset>
80108a89:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108a8c:	8d 83 a0 00 00 00    	lea    0xa0(%ebx),%eax
80108a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108a95:	eb 4e                	jmp    80108ae5 <setupkvm+0x96>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a9a:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0) {
80108a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aa0:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aa6:	8b 70 08             	mov    0x8(%eax),%esi
80108aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aac:	8b 40 04             	mov    0x4(%eax),%eax
80108aaf:	29 c6                	sub    %eax,%esi
80108ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ab4:	8b 00                	mov    (%eax),%eax
80108ab6:	83 ec 0c             	sub    $0xc,%esp
80108ab9:	51                   	push   %ecx
80108aba:	52                   	push   %edx
80108abb:	56                   	push   %esi
80108abc:	50                   	push   %eax
80108abd:	ff 75 f0             	push   -0x10(%ebp)
80108ac0:	e8 e9 fe ff ff       	call   801089ae <mappages>
80108ac5:	83 c4 20             	add    $0x20,%esp
80108ac8:	85 c0                	test   %eax,%eax
80108aca:	79 15                	jns    80108ae1 <setupkvm+0x92>
      freevm(pgdir);
80108acc:	83 ec 0c             	sub    $0xc,%esp
80108acf:	ff 75 f0             	push   -0x10(%ebp)
80108ad2:	e8 1b 06 00 00       	call   801090f2 <freevm>
80108ad7:	83 c4 10             	add    $0x10,%esp
      return 0;
80108ada:	b8 00 00 00 00       	mov    $0x0,%eax
80108adf:	eb 12                	jmp    80108af3 <setupkvm+0xa4>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108ae1:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80108ae5:	8d 83 e0 00 00 00    	lea    0xe0(%ebx),%eax
80108aeb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80108aee:	72 a7                	jb     80108a97 <setupkvm+0x48>
    }
  return pgdir;
80108af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80108af3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108af6:	5b                   	pop    %ebx
80108af7:	5e                   	pop    %esi
80108af8:	5d                   	pop    %ebp
80108af9:	c3                   	ret    

80108afa <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108afa:	55                   	push   %ebp
80108afb:	89 e5                	mov    %esp,%ebp
80108afd:	53                   	push   %ebx
80108afe:	83 ec 04             	sub    $0x4,%esp
80108b01:	e8 7f 78 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108b06:	81 c3 ba 39 00 00    	add    $0x39ba,%ebx
  kpgdir = setupkvm();
80108b0c:	e8 3e ff ff ff       	call   80108a4f <setupkvm>
80108b11:	89 83 3c a0 00 00    	mov    %eax,0xa03c(%ebx)
  switchkvm();
80108b17:	e8 06 00 00 00       	call   80108b22 <switchkvm>
}
80108b1c:	90                   	nop
80108b1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108b20:	c9                   	leave  
80108b21:	c3                   	ret    

80108b22 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80108b22:	55                   	push   %ebp
80108b23:	89 e5                	mov    %esp,%ebp
80108b25:	e8 fe 81 ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80108b2a:	05 96 39 00 00       	add    $0x3996,%eax
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108b2f:	8b 80 3c a0 00 00    	mov    0xa03c(%eax),%eax
80108b35:	05 00 00 00 80       	add    $0x80000000,%eax
80108b3a:	50                   	push   %eax
80108b3b:	e8 4b fa ff ff       	call   8010858b <lcr3>
80108b40:	83 c4 04             	add    $0x4,%esp
}
80108b43:	90                   	nop
80108b44:	c9                   	leave  
80108b45:	c3                   	ret    

80108b46 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108b46:	55                   	push   %ebp
80108b47:	89 e5                	mov    %esp,%ebp
80108b49:	57                   	push   %edi
80108b4a:	56                   	push   %esi
80108b4b:	53                   	push   %ebx
80108b4c:	83 ec 1c             	sub    $0x1c,%esp
80108b4f:	e8 31 78 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108b54:	81 c3 6c 39 00 00    	add    $0x396c,%ebx
  if(p == 0)
80108b5a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108b5e:	75 0f                	jne    80108b6f <switchuvm+0x29>
    panic("switchuvm: no process");
80108b60:	83 ec 0c             	sub    $0xc,%esp
80108b63:	8d 83 82 d5 ff ff    	lea    -0x2a7e(%ebx),%eax
80108b69:	50                   	push   %eax
80108b6a:	e8 06 7b ff ff       	call   80100675 <panic>
  if(p->kstack == 0)
80108b6f:	8b 45 08             	mov    0x8(%ebp),%eax
80108b72:	8b 40 08             	mov    0x8(%eax),%eax
80108b75:	85 c0                	test   %eax,%eax
80108b77:	75 0f                	jne    80108b88 <switchuvm+0x42>
    panic("switchuvm: no kstack");
80108b79:	83 ec 0c             	sub    $0xc,%esp
80108b7c:	8d 83 98 d5 ff ff    	lea    -0x2a68(%ebx),%eax
80108b82:	50                   	push   %eax
80108b83:	e8 ed 7a ff ff       	call   80100675 <panic>
  if(p->pgdir == 0)
80108b88:	8b 45 08             	mov    0x8(%ebp),%eax
80108b8b:	8b 40 04             	mov    0x4(%eax),%eax
80108b8e:	85 c0                	test   %eax,%eax
80108b90:	75 0f                	jne    80108ba1 <switchuvm+0x5b>
    panic("switchuvm: no pgdir");
80108b92:	83 ec 0c             	sub    $0xc,%esp
80108b95:	8d 83 ad d5 ff ff    	lea    -0x2a53(%ebx),%eax
80108b9b:	50                   	push   %eax
80108b9c:	e8 d4 7a ff ff       	call   80100675 <panic>

  pushcli();
80108ba1:	e8 0d d1 ff ff       	call   80105cb3 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108ba6:	e8 67 bf ff ff       	call   80104b12 <mycpu>
80108bab:	89 c6                	mov    %eax,%esi
80108bad:	e8 60 bf ff ff       	call   80104b12 <mycpu>
80108bb2:	83 c0 08             	add    $0x8,%eax
80108bb5:	89 c7                	mov    %eax,%edi
80108bb7:	e8 56 bf ff ff       	call   80104b12 <mycpu>
80108bbc:	83 c0 08             	add    $0x8,%eax
80108bbf:	c1 e8 10             	shr    $0x10,%eax
80108bc2:	88 45 e7             	mov    %al,-0x19(%ebp)
80108bc5:	e8 48 bf ff ff       	call   80104b12 <mycpu>
80108bca:	83 c0 08             	add    $0x8,%eax
80108bcd:	c1 e8 18             	shr    $0x18,%eax
80108bd0:	89 c2                	mov    %eax,%edx
80108bd2:	66 c7 86 98 00 00 00 	movw   $0x67,0x98(%esi)
80108bd9:	67 00 
80108bdb:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80108be2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80108be6:	88 86 9c 00 00 00    	mov    %al,0x9c(%esi)
80108bec:	0f b6 86 9d 00 00 00 	movzbl 0x9d(%esi),%eax
80108bf3:	83 e0 f0             	and    $0xfffffff0,%eax
80108bf6:	83 c8 09             	or     $0x9,%eax
80108bf9:	88 86 9d 00 00 00    	mov    %al,0x9d(%esi)
80108bff:	0f b6 86 9d 00 00 00 	movzbl 0x9d(%esi),%eax
80108c06:	83 c8 10             	or     $0x10,%eax
80108c09:	88 86 9d 00 00 00    	mov    %al,0x9d(%esi)
80108c0f:	0f b6 86 9d 00 00 00 	movzbl 0x9d(%esi),%eax
80108c16:	83 e0 9f             	and    $0xffffff9f,%eax
80108c19:	88 86 9d 00 00 00    	mov    %al,0x9d(%esi)
80108c1f:	0f b6 86 9d 00 00 00 	movzbl 0x9d(%esi),%eax
80108c26:	83 c8 80             	or     $0xffffff80,%eax
80108c29:	88 86 9d 00 00 00    	mov    %al,0x9d(%esi)
80108c2f:	0f b6 86 9e 00 00 00 	movzbl 0x9e(%esi),%eax
80108c36:	83 e0 f0             	and    $0xfffffff0,%eax
80108c39:	88 86 9e 00 00 00    	mov    %al,0x9e(%esi)
80108c3f:	0f b6 86 9e 00 00 00 	movzbl 0x9e(%esi),%eax
80108c46:	83 e0 ef             	and    $0xffffffef,%eax
80108c49:	88 86 9e 00 00 00    	mov    %al,0x9e(%esi)
80108c4f:	0f b6 86 9e 00 00 00 	movzbl 0x9e(%esi),%eax
80108c56:	83 e0 df             	and    $0xffffffdf,%eax
80108c59:	88 86 9e 00 00 00    	mov    %al,0x9e(%esi)
80108c5f:	0f b6 86 9e 00 00 00 	movzbl 0x9e(%esi),%eax
80108c66:	83 c8 40             	or     $0x40,%eax
80108c69:	88 86 9e 00 00 00    	mov    %al,0x9e(%esi)
80108c6f:	0f b6 86 9e 00 00 00 	movzbl 0x9e(%esi),%eax
80108c76:	83 e0 7f             	and    $0x7f,%eax
80108c79:	88 86 9e 00 00 00    	mov    %al,0x9e(%esi)
80108c7f:	88 96 9f 00 00 00    	mov    %dl,0x9f(%esi)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80108c85:	e8 88 be ff ff       	call   80104b12 <mycpu>
80108c8a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108c91:	83 e2 ef             	and    $0xffffffef,%edx
80108c94:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108c9a:	e8 73 be ff ff       	call   80104b12 <mycpu>
80108c9f:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108ca5:	8b 45 08             	mov    0x8(%ebp),%eax
80108ca8:	8b 40 08             	mov    0x8(%eax),%eax
80108cab:	89 c6                	mov    %eax,%esi
80108cad:	e8 60 be ff ff       	call   80104b12 <mycpu>
80108cb2:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
80108cb8:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108cbb:	e8 52 be ff ff       	call   80104b12 <mycpu>
80108cc0:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
80108cc6:	83 ec 0c             	sub    $0xc,%esp
80108cc9:	6a 28                	push   $0x28
80108ccb:	e8 9a f8 ff ff       	call   8010856a <ltr>
80108cd0:	83 c4 10             	add    $0x10,%esp
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108cd3:	8b 45 08             	mov    0x8(%ebp),%eax
80108cd6:	8b 40 04             	mov    0x4(%eax),%eax
80108cd9:	05 00 00 00 80       	add    $0x80000000,%eax
80108cde:	83 ec 0c             	sub    $0xc,%esp
80108ce1:	50                   	push   %eax
80108ce2:	e8 a4 f8 ff ff       	call   8010858b <lcr3>
80108ce7:	83 c4 10             	add    $0x10,%esp
  popcli();
80108cea:	e8 20 d0 ff ff       	call   80105d0f <popcli>
}
80108cef:	90                   	nop
80108cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108cf3:	5b                   	pop    %ebx
80108cf4:	5e                   	pop    %esi
80108cf5:	5f                   	pop    %edi
80108cf6:	5d                   	pop    %ebp
80108cf7:	c3                   	ret    

80108cf8 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108cf8:	55                   	push   %ebp
80108cf9:	89 e5                	mov    %esp,%ebp
80108cfb:	53                   	push   %ebx
80108cfc:	83 ec 14             	sub    $0x14,%esp
80108cff:	e8 81 76 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108d04:	81 c3 bc 37 00 00    	add    $0x37bc,%ebx
  char *mem;

  if(sz >= PGSIZE)
80108d0a:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108d11:	76 0f                	jbe    80108d22 <inituvm+0x2a>
    panic("inituvm: more than a page");
80108d13:	83 ec 0c             	sub    $0xc,%esp
80108d16:	8d 83 c1 d5 ff ff    	lea    -0x2a3f(%ebx),%eax
80108d1c:	50                   	push   %eax
80108d1d:	e8 53 79 ff ff       	call   80100675 <panic>
  mem = kalloc();
80108d22:	e8 72 a5 ff ff       	call   80103299 <kalloc>
80108d27:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80108d2a:	83 ec 04             	sub    $0x4,%esp
80108d2d:	68 00 10 00 00       	push   $0x1000
80108d32:	6a 00                	push   $0x0
80108d34:	ff 75 f4             	push   -0xc(%ebp)
80108d37:	e8 b8 d0 ff ff       	call   80105df4 <memset>
80108d3c:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80108d3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d42:	05 00 00 00 80       	add    $0x80000000,%eax
80108d47:	83 ec 0c             	sub    $0xc,%esp
80108d4a:	6a 06                	push   $0x6
80108d4c:	50                   	push   %eax
80108d4d:	68 00 10 00 00       	push   $0x1000
80108d52:	6a 00                	push   $0x0
80108d54:	ff 75 08             	push   0x8(%ebp)
80108d57:	e8 52 fc ff ff       	call   801089ae <mappages>
80108d5c:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80108d5f:	83 ec 04             	sub    $0x4,%esp
80108d62:	ff 75 10             	push   0x10(%ebp)
80108d65:	ff 75 0c             	push   0xc(%ebp)
80108d68:	ff 75 f4             	push   -0xc(%ebp)
80108d6b:	e8 57 d1 ff ff       	call   80105ec7 <memmove>
80108d70:	83 c4 10             	add    $0x10,%esp
}
80108d73:	90                   	nop
80108d74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108d77:	c9                   	leave  
80108d78:	c3                   	ret    

80108d79 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108d79:	55                   	push   %ebp
80108d7a:	89 e5                	mov    %esp,%ebp
80108d7c:	53                   	push   %ebx
80108d7d:	83 ec 24             	sub    $0x24,%esp
80108d80:	e8 00 76 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108d85:	81 c3 3b 37 00 00    	add    $0x373b,%ebx
  // }
  // return 0;

  uint i, n,pa;
  uint64_t first_va,page_lookahead;
  first_va = PGROUNDDOWN((uint)addr);
80108d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80108d8e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108d93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  page_lookahead = (uint64_t)addr - first_va;
80108d96:	8b 45 0c             	mov    0xc(%ebp),%eax
80108d99:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108d9c:	89 45 e8             	mov    %eax,-0x18(%ebp)

  pte = walkpgdir(pgdir, addr, 0);
80108d9f:	83 ec 04             	sub    $0x4,%esp
80108da2:	6a 00                	push   $0x0
80108da4:	ff 75 0c             	push   0xc(%ebp)
80108da7:	ff 75 08             	push   0x8(%ebp)
80108daa:	e8 5a fb ff ff       	call   80108909 <walkpgdir>
80108daf:	83 c4 10             	add    $0x10,%esp
80108db2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pte==0)
80108db5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108db9:	75 0f                	jne    80108dca <loaduvm+0x51>
  {
    panic("page table address does not exist");
80108dbb:	83 ec 0c             	sub    $0xc,%esp
80108dbe:	8d 83 dc d5 ff ff    	lea    -0x2a24(%ebx),%eax
80108dc4:	50                   	push   %eax
80108dc5:	e8 ab 78 ff ff       	call   80100675 <panic>
  }
  pa = PTE_ADDR(*pte);
80108dca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108dcd:	8b 00                	mov    (%eax),%eax
80108dcf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108dd4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(pa==0)
80108dd7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108ddb:	75 0f                	jne    80108dec <loaduvm+0x73>
  {
    panic("page address should exist");
80108ddd:	83 ec 0c             	sub    $0xc,%esp
80108de0:	8d 83 fe d5 ff ff    	lea    -0x2a02(%ebx),%eax
80108de6:	50                   	push   %eax
80108de7:	e8 89 78 ff ff       	call   80100675 <panic>
  }
  pa+=page_lookahead;
80108dec:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108def:	01 45 e0             	add    %eax,-0x20(%ebp)
  if(sz < PGSIZE - page_lookahead)
80108df2:	b8 00 10 00 00       	mov    $0x1000,%eax
80108df7:	2b 45 e8             	sub    -0x18(%ebp),%eax
80108dfa:	39 45 18             	cmp    %eax,0x18(%ebp)
80108dfd:	73 08                	jae    80108e07 <loaduvm+0x8e>
  {
    n=sz;
80108dff:	8b 45 18             	mov    0x18(%ebp),%eax
80108e02:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108e05:	eb 0b                	jmp    80108e12 <loaduvm+0x99>
  }
  else
  {
    n=PGSIZE - page_lookahead;
80108e07:	b8 00 10 00 00       	mov    $0x1000,%eax
80108e0c:	2b 45 e8             	sub    -0x18(%ebp),%eax
80108e0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  }
  if(readi(ip, P2V(pa), offset, n) != n)
80108e12:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108e15:	05 00 00 00 80       	add    $0x80000000,%eax
80108e1a:	ff 75 f0             	push   -0x10(%ebp)
80108e1d:	ff 75 14             	push   0x14(%ebp)
80108e20:	50                   	push   %eax
80108e21:	ff 75 10             	push   0x10(%ebp)
80108e24:	e8 2b 95 ff ff       	call   80102354 <readi>
80108e29:	83 c4 10             	add    $0x10,%esp
80108e2c:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80108e2f:	74 0a                	je     80108e3b <loaduvm+0xc2>
    return -1;
80108e31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108e36:	e9 c5 00 00 00       	jmp    80108f00 <loaduvm+0x187>
  
  offset =offset+ n;
80108e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e3e:	01 45 14             	add    %eax,0x14(%ebp)
  sz =sz-n;
80108e41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108e44:	29 45 18             	sub    %eax,0x18(%ebp)
  addr=addr+PGSIZE-page_lookahead;
80108e47:	b8 00 10 00 00       	mov    $0x1000,%eax
80108e4c:	2b 45 e8             	sub    -0x18(%ebp),%eax
80108e4f:	01 45 0c             	add    %eax,0xc(%ebp)
  
  for(i = 0; i < sz; i += PGSIZE)
80108e52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108e59:	e9 91 00 00 00       	jmp    80108eef <loaduvm+0x176>
  {
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108e5e:	8b 55 0c             	mov    0xc(%ebp),%edx
80108e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108e64:	01 d0                	add    %edx,%eax
80108e66:	83 ec 04             	sub    $0x4,%esp
80108e69:	6a 00                	push   $0x0
80108e6b:	50                   	push   %eax
80108e6c:	ff 75 08             	push   0x8(%ebp)
80108e6f:	e8 95 fa ff ff       	call   80108909 <walkpgdir>
80108e74:	83 c4 10             	add    $0x10,%esp
80108e77:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108e7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108e7e:	75 0f                	jne    80108e8f <loaduvm+0x116>
      panic("loaduvm: address should exist");
80108e80:	83 ec 0c             	sub    $0xc,%esp
80108e83:	8d 83 18 d6 ff ff    	lea    -0x29e8(%ebx),%eax
80108e89:	50                   	push   %eax
80108e8a:	e8 e6 77 ff ff       	call   80100675 <panic>
    pa = PTE_ADDR(*pte);
80108e8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108e92:	8b 00                	mov    (%eax),%eax
80108e94:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108e99:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(sz - i < PGSIZE)
80108e9c:	8b 45 18             	mov    0x18(%ebp),%eax
80108e9f:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108ea2:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108ea7:	77 0b                	ja     80108eb4 <loaduvm+0x13b>
      n = sz - i;
80108ea9:	8b 45 18             	mov    0x18(%ebp),%eax
80108eac:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108eaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108eb2:	eb 07                	jmp    80108ebb <loaduvm+0x142>
    else
      n = PGSIZE;
80108eb4:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108ebb:	8b 55 14             	mov    0x14(%ebp),%edx
80108ebe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ec1:	01 d0                	add    %edx,%eax
80108ec3:	8b 55 e0             	mov    -0x20(%ebp),%edx
80108ec6:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108ecc:	ff 75 f0             	push   -0x10(%ebp)
80108ecf:	50                   	push   %eax
80108ed0:	52                   	push   %edx
80108ed1:	ff 75 10             	push   0x10(%ebp)
80108ed4:	e8 7b 94 ff ff       	call   80102354 <readi>
80108ed9:	83 c4 10             	add    $0x10,%esp
80108edc:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80108edf:	74 07                	je     80108ee8 <loaduvm+0x16f>
      return -1;
80108ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108ee6:	eb 18                	jmp    80108f00 <loaduvm+0x187>
  for(i = 0; i < sz; i += PGSIZE)
80108ee8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108eef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ef2:	3b 45 18             	cmp    0x18(%ebp),%eax
80108ef5:	0f 82 63 ff ff ff    	jb     80108e5e <loaduvm+0xe5>
  }
  return 0;
80108efb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108f00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108f03:	c9                   	leave  
80108f04:	c3                   	ret    

80108f05 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108f05:	55                   	push   %ebp
80108f06:	89 e5                	mov    %esp,%ebp
80108f08:	53                   	push   %ebx
80108f09:	83 ec 14             	sub    $0x14,%esp
80108f0c:	e8 74 74 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80108f11:	81 c3 af 35 00 00    	add    $0x35af,%ebx
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80108f17:	8b 45 10             	mov    0x10(%ebp),%eax
80108f1a:	85 c0                	test   %eax,%eax
80108f1c:	79 0a                	jns    80108f28 <allocuvm+0x23>
    return 0;
80108f1e:	b8 00 00 00 00       	mov    $0x0,%eax
80108f23:	e9 f0 00 00 00       	jmp    80109018 <allocuvm+0x113>
  if(newsz < oldsz)
80108f28:	8b 45 10             	mov    0x10(%ebp),%eax
80108f2b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108f2e:	73 08                	jae    80108f38 <allocuvm+0x33>
    return oldsz;
80108f30:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f33:	e9 e0 00 00 00       	jmp    80109018 <allocuvm+0x113>

  a = PGROUNDUP(oldsz);
80108f38:	8b 45 0c             	mov    0xc(%ebp),%eax
80108f3b:	05 ff 0f 00 00       	add    $0xfff,%eax
80108f40:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108f45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80108f48:	e9 bc 00 00 00       	jmp    80109009 <allocuvm+0x104>
    mem = kalloc();
80108f4d:	e8 47 a3 ff ff       	call   80103299 <kalloc>
80108f52:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80108f55:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108f59:	75 30                	jne    80108f8b <allocuvm+0x86>
      cprintf("allocuvm out of memory\n");
80108f5b:	83 ec 0c             	sub    $0xc,%esp
80108f5e:	8d 83 36 d6 ff ff    	lea    -0x29ca(%ebx),%eax
80108f64:	50                   	push   %eax
80108f65:	e8 3e 75 ff ff       	call   801004a8 <cprintf>
80108f6a:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80108f6d:	83 ec 04             	sub    $0x4,%esp
80108f70:	ff 75 0c             	push   0xc(%ebp)
80108f73:	ff 75 10             	push   0x10(%ebp)
80108f76:	ff 75 08             	push   0x8(%ebp)
80108f79:	e8 9f 00 00 00       	call   8010901d <deallocuvm>
80108f7e:	83 c4 10             	add    $0x10,%esp
      return 0;
80108f81:	b8 00 00 00 00       	mov    $0x0,%eax
80108f86:	e9 8d 00 00 00       	jmp    80109018 <allocuvm+0x113>
    }
    memset(mem, 0, PGSIZE);
80108f8b:	83 ec 04             	sub    $0x4,%esp
80108f8e:	68 00 10 00 00       	push   $0x1000
80108f93:	6a 00                	push   $0x0
80108f95:	ff 75 f0             	push   -0x10(%ebp)
80108f98:	e8 57 ce ff ff       	call   80105df4 <memset>
80108f9d:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108fa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108fa3:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80108fa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108fac:	83 ec 0c             	sub    $0xc,%esp
80108faf:	6a 06                	push   $0x6
80108fb1:	52                   	push   %edx
80108fb2:	68 00 10 00 00       	push   $0x1000
80108fb7:	50                   	push   %eax
80108fb8:	ff 75 08             	push   0x8(%ebp)
80108fbb:	e8 ee f9 ff ff       	call   801089ae <mappages>
80108fc0:	83 c4 20             	add    $0x20,%esp
80108fc3:	85 c0                	test   %eax,%eax
80108fc5:	79 3b                	jns    80109002 <allocuvm+0xfd>
      cprintf("allocuvm out of memory (2)\n");
80108fc7:	83 ec 0c             	sub    $0xc,%esp
80108fca:	8d 83 4e d6 ff ff    	lea    -0x29b2(%ebx),%eax
80108fd0:	50                   	push   %eax
80108fd1:	e8 d2 74 ff ff       	call   801004a8 <cprintf>
80108fd6:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80108fd9:	83 ec 04             	sub    $0x4,%esp
80108fdc:	ff 75 0c             	push   0xc(%ebp)
80108fdf:	ff 75 10             	push   0x10(%ebp)
80108fe2:	ff 75 08             	push   0x8(%ebp)
80108fe5:	e8 33 00 00 00       	call   8010901d <deallocuvm>
80108fea:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
80108fed:	83 ec 0c             	sub    $0xc,%esp
80108ff0:	ff 75 f0             	push   -0x10(%ebp)
80108ff3:	e8 ed a1 ff ff       	call   801031e5 <kfree>
80108ff8:	83 c4 10             	add    $0x10,%esp
      return 0;
80108ffb:	b8 00 00 00 00       	mov    $0x0,%eax
80109000:	eb 16                	jmp    80109018 <allocuvm+0x113>
  for(; a < newsz; a += PGSIZE){
80109002:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109009:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010900c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010900f:	0f 82 38 ff ff ff    	jb     80108f4d <allocuvm+0x48>
    }
  }
  return newsz;
80109015:	8b 45 10             	mov    0x10(%ebp),%eax
}
80109018:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010901b:	c9                   	leave  
8010901c:	c3                   	ret    

8010901d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010901d:	55                   	push   %ebp
8010901e:	89 e5                	mov    %esp,%ebp
80109020:	53                   	push   %ebx
80109021:	83 ec 14             	sub    $0x14,%esp
80109024:	e8 5c 73 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80109029:	81 c3 97 34 00 00    	add    $0x3497,%ebx
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010902f:	8b 45 10             	mov    0x10(%ebp),%eax
80109032:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109035:	72 08                	jb     8010903f <deallocuvm+0x22>
    return oldsz;
80109037:	8b 45 0c             	mov    0xc(%ebp),%eax
8010903a:	e9 ae 00 00 00       	jmp    801090ed <deallocuvm+0xd0>

  a = PGROUNDUP(newsz);
8010903f:	8b 45 10             	mov    0x10(%ebp),%eax
80109042:	05 ff 0f 00 00       	add    $0xfff,%eax
80109047:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010904c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010904f:	e9 8a 00 00 00       	jmp    801090de <deallocuvm+0xc1>
    pte = walkpgdir(pgdir, (char*)a, 0);
80109054:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109057:	83 ec 04             	sub    $0x4,%esp
8010905a:	6a 00                	push   $0x0
8010905c:	50                   	push   %eax
8010905d:	ff 75 08             	push   0x8(%ebp)
80109060:	e8 a4 f8 ff ff       	call   80108909 <walkpgdir>
80109065:	83 c4 10             	add    $0x10,%esp
80109068:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010906b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010906f:	75 16                	jne    80109087 <deallocuvm+0x6a>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80109071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109074:	c1 e8 16             	shr    $0x16,%eax
80109077:	83 c0 01             	add    $0x1,%eax
8010907a:	c1 e0 16             	shl    $0x16,%eax
8010907d:	2d 00 10 00 00       	sub    $0x1000,%eax
80109082:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109085:	eb 50                	jmp    801090d7 <deallocuvm+0xba>
    else if((*pte & PTE_P) != 0){
80109087:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010908a:	8b 00                	mov    (%eax),%eax
8010908c:	83 e0 01             	and    $0x1,%eax
8010908f:	85 c0                	test   %eax,%eax
80109091:	74 44                	je     801090d7 <deallocuvm+0xba>
      pa = PTE_ADDR(*pte);
80109093:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109096:	8b 00                	mov    (%eax),%eax
80109098:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010909d:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801090a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801090a4:	75 0f                	jne    801090b5 <deallocuvm+0x98>
        panic("kfree");
801090a6:	83 ec 0c             	sub    $0xc,%esp
801090a9:	8d 83 6a d6 ff ff    	lea    -0x2996(%ebx),%eax
801090af:	50                   	push   %eax
801090b0:	e8 c0 75 ff ff       	call   80100675 <panic>
      char *v = P2V(pa);
801090b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801090b8:	05 00 00 00 80       	add    $0x80000000,%eax
801090bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801090c0:	83 ec 0c             	sub    $0xc,%esp
801090c3:	ff 75 e8             	push   -0x18(%ebp)
801090c6:	e8 1a a1 ff ff       	call   801031e5 <kfree>
801090cb:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801090ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801090d1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801090d7:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801090de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090e1:	3b 45 0c             	cmp    0xc(%ebp),%eax
801090e4:	0f 82 6a ff ff ff    	jb     80109054 <deallocuvm+0x37>
    }
  }
  return newsz;
801090ea:	8b 45 10             	mov    0x10(%ebp),%eax
}
801090ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801090f0:	c9                   	leave  
801090f1:	c3                   	ret    

801090f2 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801090f2:	55                   	push   %ebp
801090f3:	89 e5                	mov    %esp,%ebp
801090f5:	53                   	push   %ebx
801090f6:	83 ec 14             	sub    $0x14,%esp
801090f9:	e8 87 72 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801090fe:	81 c3 c2 33 00 00    	add    $0x33c2,%ebx
  uint i;

  if(pgdir == 0)
80109104:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80109108:	75 0f                	jne    80109119 <freevm+0x27>
    panic("freevm: no pgdir");
8010910a:	83 ec 0c             	sub    $0xc,%esp
8010910d:	8d 83 70 d6 ff ff    	lea    -0x2990(%ebx),%eax
80109113:	50                   	push   %eax
80109114:	e8 5c 75 ff ff       	call   80100675 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80109119:	83 ec 04             	sub    $0x4,%esp
8010911c:	6a 00                	push   $0x0
8010911e:	68 00 00 00 80       	push   $0x80000000
80109123:	ff 75 08             	push   0x8(%ebp)
80109126:	e8 f2 fe ff ff       	call   8010901d <deallocuvm>
8010912b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010912e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109135:	eb 48                	jmp    8010917f <freevm+0x8d>
    if(pgdir[i] & PTE_P){
80109137:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010913a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109141:	8b 45 08             	mov    0x8(%ebp),%eax
80109144:	01 d0                	add    %edx,%eax
80109146:	8b 00                	mov    (%eax),%eax
80109148:	83 e0 01             	and    $0x1,%eax
8010914b:	85 c0                	test   %eax,%eax
8010914d:	74 2c                	je     8010917b <freevm+0x89>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010914f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109152:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109159:	8b 45 08             	mov    0x8(%ebp),%eax
8010915c:	01 d0                	add    %edx,%eax
8010915e:	8b 00                	mov    (%eax),%eax
80109160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109165:	05 00 00 00 80       	add    $0x80000000,%eax
8010916a:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010916d:	83 ec 0c             	sub    $0xc,%esp
80109170:	ff 75 f0             	push   -0x10(%ebp)
80109173:	e8 6d a0 ff ff       	call   801031e5 <kfree>
80109178:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010917b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010917f:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80109186:	76 af                	jbe    80109137 <freevm+0x45>
    }
  }
  kfree((char*)pgdir);
80109188:	83 ec 0c             	sub    $0xc,%esp
8010918b:	ff 75 08             	push   0x8(%ebp)
8010918e:	e8 52 a0 ff ff       	call   801031e5 <kfree>
80109193:	83 c4 10             	add    $0x10,%esp
}
80109196:	90                   	nop
80109197:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010919a:	c9                   	leave  
8010919b:	c3                   	ret    

8010919c <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010919c:	55                   	push   %ebp
8010919d:	89 e5                	mov    %esp,%ebp
8010919f:	53                   	push   %ebx
801091a0:	83 ec 14             	sub    $0x14,%esp
801091a3:	e8 dd 71 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801091a8:	81 c3 18 33 00 00    	add    $0x3318,%ebx
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801091ae:	83 ec 04             	sub    $0x4,%esp
801091b1:	6a 00                	push   $0x0
801091b3:	ff 75 0c             	push   0xc(%ebp)
801091b6:	ff 75 08             	push   0x8(%ebp)
801091b9:	e8 4b f7 ff ff       	call   80108909 <walkpgdir>
801091be:	83 c4 10             	add    $0x10,%esp
801091c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801091c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801091c8:	75 0f                	jne    801091d9 <clearpteu+0x3d>
    panic("clearpteu");
801091ca:	83 ec 0c             	sub    $0xc,%esp
801091cd:	8d 83 81 d6 ff ff    	lea    -0x297f(%ebx),%eax
801091d3:	50                   	push   %eax
801091d4:	e8 9c 74 ff ff       	call   80100675 <panic>
  *pte &= ~PTE_U;
801091d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091dc:	8b 00                	mov    (%eax),%eax
801091de:	83 e0 fb             	and    $0xfffffffb,%eax
801091e1:	89 c2                	mov    %eax,%edx
801091e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091e6:	89 10                	mov    %edx,(%eax)
}
801091e8:	90                   	nop
801091e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801091ec:	c9                   	leave  
801091ed:	c3                   	ret    

801091ee <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801091ee:	55                   	push   %ebp
801091ef:	89 e5                	mov    %esp,%ebp
801091f1:	53                   	push   %ebx
801091f2:	83 ec 24             	sub    $0x24,%esp
801091f5:	e8 8b 71 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
801091fa:	81 c3 c6 32 00 00    	add    $0x32c6,%ebx
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80109200:	e8 4a f8 ff ff       	call   80108a4f <setupkvm>
80109205:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109208:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010920c:	75 0a                	jne    80109218 <copyuvm+0x2a>
    return 0;
8010920e:	b8 00 00 00 00       	mov    $0x0,%eax
80109213:	e9 fc 00 00 00       	jmp    80109314 <copyuvm+0x126>
  for(i = 0; i < sz; i += PGSIZE){
80109218:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010921f:	e9 cb 00 00 00       	jmp    801092ef <copyuvm+0x101>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80109224:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109227:	83 ec 04             	sub    $0x4,%esp
8010922a:	6a 00                	push   $0x0
8010922c:	50                   	push   %eax
8010922d:	ff 75 08             	push   0x8(%ebp)
80109230:	e8 d4 f6 ff ff       	call   80108909 <walkpgdir>
80109235:	83 c4 10             	add    $0x10,%esp
80109238:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010923b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010923f:	75 0f                	jne    80109250 <copyuvm+0x62>
      panic("copyuvm: pte should exist");
80109241:	83 ec 0c             	sub    $0xc,%esp
80109244:	8d 83 8b d6 ff ff    	lea    -0x2975(%ebx),%eax
8010924a:	50                   	push   %eax
8010924b:	e8 25 74 ff ff       	call   80100675 <panic>
    if(!(*pte & PTE_P))
80109250:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109253:	8b 00                	mov    (%eax),%eax
80109255:	83 e0 01             	and    $0x1,%eax
80109258:	85 c0                	test   %eax,%eax
8010925a:	75 0f                	jne    8010926b <copyuvm+0x7d>
      panic("copyuvm: page not present");
8010925c:	83 ec 0c             	sub    $0xc,%esp
8010925f:	8d 83 a5 d6 ff ff    	lea    -0x295b(%ebx),%eax
80109265:	50                   	push   %eax
80109266:	e8 0a 74 ff ff       	call   80100675 <panic>
    pa = PTE_ADDR(*pte);
8010926b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010926e:	8b 00                	mov    (%eax),%eax
80109270:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109275:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80109278:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010927b:	8b 00                	mov    (%eax),%eax
8010927d:	25 ff 0f 00 00       	and    $0xfff,%eax
80109282:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80109285:	e8 0f a0 ff ff       	call   80103299 <kalloc>
8010928a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010928d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80109291:	74 6d                	je     80109300 <copyuvm+0x112>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80109293:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109296:	05 00 00 00 80       	add    $0x80000000,%eax
8010929b:	83 ec 04             	sub    $0x4,%esp
8010929e:	68 00 10 00 00       	push   $0x1000
801092a3:	50                   	push   %eax
801092a4:	ff 75 e0             	push   -0x20(%ebp)
801092a7:	e8 1b cc ff ff       	call   80105ec7 <memmove>
801092ac:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801092af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801092b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801092b5:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801092bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092be:	83 ec 0c             	sub    $0xc,%esp
801092c1:	52                   	push   %edx
801092c2:	51                   	push   %ecx
801092c3:	68 00 10 00 00       	push   $0x1000
801092c8:	50                   	push   %eax
801092c9:	ff 75 f0             	push   -0x10(%ebp)
801092cc:	e8 dd f6 ff ff       	call   801089ae <mappages>
801092d1:	83 c4 20             	add    $0x20,%esp
801092d4:	85 c0                	test   %eax,%eax
801092d6:	79 10                	jns    801092e8 <copyuvm+0xfa>
      kfree(mem);
801092d8:	83 ec 0c             	sub    $0xc,%esp
801092db:	ff 75 e0             	push   -0x20(%ebp)
801092de:	e8 02 9f ff ff       	call   801031e5 <kfree>
801092e3:	83 c4 10             	add    $0x10,%esp
      goto bad;
801092e6:	eb 19                	jmp    80109301 <copyuvm+0x113>
  for(i = 0; i < sz; i += PGSIZE){
801092e8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801092ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092f2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801092f5:	0f 82 29 ff ff ff    	jb     80109224 <copyuvm+0x36>
    }
  }
  return d;
801092fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801092fe:	eb 14                	jmp    80109314 <copyuvm+0x126>
      goto bad;
80109300:	90                   	nop

bad:
  freevm(d);
80109301:	83 ec 0c             	sub    $0xc,%esp
80109304:	ff 75 f0             	push   -0x10(%ebp)
80109307:	e8 e6 fd ff ff       	call   801090f2 <freevm>
8010930c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010930f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109314:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109317:	c9                   	leave  
80109318:	c3                   	ret    

80109319 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80109319:	55                   	push   %ebp
8010931a:	89 e5                	mov    %esp,%ebp
8010931c:	83 ec 18             	sub    $0x18,%esp
8010931f:	e8 04 7a ff ff       	call   80100d28 <__x86.get_pc_thunk.ax>
80109324:	05 9c 31 00 00       	add    $0x319c,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80109329:	83 ec 04             	sub    $0x4,%esp
8010932c:	6a 00                	push   $0x0
8010932e:	ff 75 0c             	push   0xc(%ebp)
80109331:	ff 75 08             	push   0x8(%ebp)
80109334:	e8 d0 f5 ff ff       	call   80108909 <walkpgdir>
80109339:	83 c4 10             	add    $0x10,%esp
8010933c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010933f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109342:	8b 00                	mov    (%eax),%eax
80109344:	83 e0 01             	and    $0x1,%eax
80109347:	85 c0                	test   %eax,%eax
80109349:	75 07                	jne    80109352 <uva2ka+0x39>
    return 0;
8010934b:	b8 00 00 00 00       	mov    $0x0,%eax
80109350:	eb 22                	jmp    80109374 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
80109352:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109355:	8b 00                	mov    (%eax),%eax
80109357:	83 e0 04             	and    $0x4,%eax
8010935a:	85 c0                	test   %eax,%eax
8010935c:	75 07                	jne    80109365 <uva2ka+0x4c>
    return 0;
8010935e:	b8 00 00 00 00       	mov    $0x0,%eax
80109363:	eb 0f                	jmp    80109374 <uva2ka+0x5b>
  return (char*)P2V(PTE_ADDR(*pte));
80109365:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109368:	8b 00                	mov    (%eax),%eax
8010936a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010936f:	05 00 00 00 80       	add    $0x80000000,%eax
}
80109374:	c9                   	leave  
80109375:	c3                   	ret    

80109376 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80109376:	55                   	push   %ebp
80109377:	89 e5                	mov    %esp,%ebp
80109379:	53                   	push   %ebx
8010937a:	83 ec 14             	sub    $0x14,%esp
8010937d:	e8 03 70 ff ff       	call   80100385 <__x86.get_pc_thunk.bx>
80109382:	81 c3 3e 31 00 00    	add    $0x313e,%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80109388:	8b 45 10             	mov    0x10(%ebp),%eax
8010938b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010938e:	eb 7f                	jmp    8010940f <copyout+0x99>
    va0 = (uint)PGROUNDDOWN(va);
80109390:	8b 45 0c             	mov    0xc(%ebp),%eax
80109393:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109398:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010939b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010939e:	83 ec 08             	sub    $0x8,%esp
801093a1:	50                   	push   %eax
801093a2:	ff 75 08             	push   0x8(%ebp)
801093a5:	e8 6f ff ff ff       	call   80109319 <uva2ka>
801093aa:	83 c4 10             	add    $0x10,%esp
801093ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801093b0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801093b4:	75 07                	jne    801093bd <copyout+0x47>
      return -1;
801093b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801093bb:	eb 61                	jmp    8010941e <copyout+0xa8>
    n = PGSIZE - (va - va0);
801093bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801093c0:	2b 45 0c             	sub    0xc(%ebp),%eax
801093c3:	05 00 10 00 00       	add    $0x1000,%eax
801093c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801093cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801093ce:	3b 45 14             	cmp    0x14(%ebp),%eax
801093d1:	76 06                	jbe    801093d9 <copyout+0x63>
      n = len;
801093d3:	8b 45 14             	mov    0x14(%ebp),%eax
801093d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801093d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801093dc:	2b 45 ec             	sub    -0x14(%ebp),%eax
801093df:	89 c2                	mov    %eax,%edx
801093e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801093e4:	01 d0                	add    %edx,%eax
801093e6:	83 ec 04             	sub    $0x4,%esp
801093e9:	ff 75 f0             	push   -0x10(%ebp)
801093ec:	ff 75 f4             	push   -0xc(%ebp)
801093ef:	50                   	push   %eax
801093f0:	e8 d2 ca ff ff       	call   80105ec7 <memmove>
801093f5:	83 c4 10             	add    $0x10,%esp
    len -= n;
801093f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801093fb:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801093fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109401:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80109404:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109407:	05 00 10 00 00       	add    $0x1000,%eax
8010940c:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
8010940f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80109413:	0f 85 77 ff ff ff    	jne    80109390 <copyout+0x1a>
  }
  return 0;
80109419:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010941e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109421:	c9                   	leave  
80109422:	c3                   	ret    
