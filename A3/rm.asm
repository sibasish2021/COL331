
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 1c             	sub    $0x1c,%esp
  13:	e8 88 00 00 00       	call   a0 <__x86.get_pc_thunk.bx>
  18:	81 c3 c8 0b 00 00    	add    $0xbc8,%ebx
  1e:	89 ce                	mov    %ecx,%esi
  int i;

  if(argc < 2){
  20:	83 3e 01             	cmpl   $0x1,(%esi)
  23:	7f 19                	jg     3e <main+0x3e>
    printf(2, "Usage: rm files...\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	8d 83 28 fd ff ff    	lea    -0x2d8(%ebx),%eax
  2e:	50                   	push   %eax
  2f:	6a 02                	push   $0x2
  31:	e8 d3 04 00 00       	call   509 <printf>
  36:	83 c4 10             	add    $0x10,%esp
    exit();
  39:	e8 2f 03 00 00       	call   36d <exit>
  }

  for(i = 1; i < argc; i++){
  3e:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  45:	eb 4d                	jmp    94 <main+0x94>
    if(unlink(argv[i]) < 0){
  47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  51:	8b 46 04             	mov    0x4(%esi),%eax
  54:	01 d0                	add    %edx,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	50                   	push   %eax
  5c:	e8 5c 03 00 00       	call   3bd <unlink>
  61:	83 c4 10             	add    $0x10,%esp
  64:	85 c0                	test   %eax,%eax
  66:	79 28                	jns    90 <main+0x90>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  72:	8b 46 04             	mov    0x4(%esi),%eax
  75:	01 d0                	add    %edx,%eax
  77:	8b 00                	mov    (%eax),%eax
  79:	83 ec 04             	sub    $0x4,%esp
  7c:	50                   	push   %eax
  7d:	8d 83 3c fd ff ff    	lea    -0x2c4(%ebx),%eax
  83:	50                   	push   %eax
  84:	6a 02                	push   $0x2
  86:	e8 7e 04 00 00       	call   509 <printf>
  8b:	83 c4 10             	add    $0x10,%esp
      break;
  8e:	eb 0b                	jmp    9b <main+0x9b>
  for(i = 1; i < argc; i++){
  90:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
  94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  97:	3b 06                	cmp    (%esi),%eax
  99:	7c ac                	jl     47 <main+0x47>
    }
  }

  exit();
  9b:	e8 cd 02 00 00       	call   36d <exit>

000000a0 <__x86.get_pc_thunk.bx>:
  a0:	8b 1c 24             	mov    (%esp),%ebx
  a3:	c3                   	ret    

000000a4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	53                   	push   %ebx
  a9:	e8 b3 02 00 00       	call   361 <__x86.get_pc_thunk.ax>
  ae:	05 32 0b 00 00       	add    $0xb32,%eax
  asm volatile("cld; rep stosb" :
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b6:	8b 55 10             	mov    0x10(%ebp),%edx
  b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  bc:	89 cb                	mov    %ecx,%ebx
  be:	89 df                	mov    %ebx,%edi
  c0:	89 d1                	mov    %edx,%ecx
  c2:	fc                   	cld    
  c3:	f3 aa                	rep stos %al,%es:(%edi)
  c5:	89 ca                	mov    %ecx,%edx
  c7:	89 fb                	mov    %edi,%ebx
  c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
  cc:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  cf:	90                   	nop
  d0:	5b                   	pop    %ebx
  d1:	5f                   	pop    %edi
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    

000000d4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	83 ec 10             	sub    $0x10,%esp
  da:	e8 82 02 00 00       	call   361 <__x86.get_pc_thunk.ax>
  df:	05 01 0b 00 00       	add    $0xb01,%eax
  char *os;

  os = s;
  e4:	8b 45 08             	mov    0x8(%ebp),%eax
  e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ea:	90                   	nop
  eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ee:	8d 42 01             	lea    0x1(%edx),%eax
  f1:	89 45 0c             	mov    %eax,0xc(%ebp)
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8d 48 01             	lea    0x1(%eax),%ecx
  fa:	89 4d 08             	mov    %ecx,0x8(%ebp)
  fd:	0f b6 12             	movzbl (%edx),%edx
 100:	88 10                	mov    %dl,(%eax)
 102:	0f b6 00             	movzbl (%eax),%eax
 105:	84 c0                	test   %al,%al
 107:	75 e2                	jne    eb <strcpy+0x17>
    ;
  return os;
 109:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 10c:	c9                   	leave  
 10d:	c3                   	ret    

0000010e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10e:	55                   	push   %ebp
 10f:	89 e5                	mov    %esp,%ebp
 111:	e8 4b 02 00 00       	call   361 <__x86.get_pc_thunk.ax>
 116:	05 ca 0a 00 00       	add    $0xaca,%eax
  while(*p && *p == *q)
 11b:	eb 08                	jmp    125 <strcmp+0x17>
    p++, q++;
 11d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 121:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	84 c0                	test   %al,%al
 12d:	74 10                	je     13f <strcmp+0x31>
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
 132:	0f b6 10             	movzbl (%eax),%edx
 135:	8b 45 0c             	mov    0xc(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	38 c2                	cmp    %al,%dl
 13d:	74 de                	je     11d <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	0f b6 00             	movzbl (%eax),%eax
 145:	0f b6 d0             	movzbl %al,%edx
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	0f b6 c8             	movzbl %al,%ecx
 151:	89 d0                	mov    %edx,%eax
 153:	29 c8                	sub    %ecx,%eax
}
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    

00000157 <strlen>:

uint
strlen(const char *s)
{
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
 15a:	83 ec 10             	sub    $0x10,%esp
 15d:	e8 ff 01 00 00       	call   361 <__x86.get_pc_thunk.ax>
 162:	05 7e 0a 00 00       	add    $0xa7e,%eax
  int n;

  for(n = 0; s[n]; n++)
 167:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 16e:	eb 04                	jmp    174 <strlen+0x1d>
 170:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 174:	8b 55 fc             	mov    -0x4(%ebp),%edx
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	01 d0                	add    %edx,%eax
 17c:	0f b6 00             	movzbl (%eax),%eax
 17f:	84 c0                	test   %al,%al
 181:	75 ed                	jne    170 <strlen+0x19>
    ;
  return n;
 183:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 186:	c9                   	leave  
 187:	c3                   	ret    

00000188 <memset>:

void*
memset(void *dst, int c, uint n)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	e8 d1 01 00 00       	call   361 <__x86.get_pc_thunk.ax>
 190:	05 50 0a 00 00       	add    $0xa50,%eax
  stosb(dst, c, n);
 195:	8b 45 10             	mov    0x10(%ebp),%eax
 198:	50                   	push   %eax
 199:	ff 75 0c             	push   0xc(%ebp)
 19c:	ff 75 08             	push   0x8(%ebp)
 19f:	e8 00 ff ff ff       	call   a4 <stosb>
 1a4:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1aa:	c9                   	leave  
 1ab:	c3                   	ret    

000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	55                   	push   %ebp
 1ad:	89 e5                	mov    %esp,%ebp
 1af:	83 ec 04             	sub    $0x4,%esp
 1b2:	e8 aa 01 00 00       	call   361 <__x86.get_pc_thunk.ax>
 1b7:	05 29 0a 00 00       	add    $0xa29,%eax
 1bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bf:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1c2:	eb 14                	jmp    1d8 <strchr+0x2c>
    if(*s == c)
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	0f b6 00             	movzbl (%eax),%eax
 1ca:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1cd:	75 05                	jne    1d4 <strchr+0x28>
      return (char*)s;
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	eb 13                	jmp    1e7 <strchr+0x3b>
  for(; *s; s++)
 1d4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	84 c0                	test   %al,%al
 1e0:	75 e2                	jne    1c4 <strchr+0x18>
  return 0;
 1e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <gets>:

char*
gets(char *buf, int max)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	53                   	push   %ebx
 1ed:	83 ec 14             	sub    $0x14,%esp
 1f0:	e8 ab fe ff ff       	call   a0 <__x86.get_pc_thunk.bx>
 1f5:	81 c3 eb 09 00 00    	add    $0x9eb,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 202:	eb 42                	jmp    246 <gets+0x5d>
    cc = read(0, &c, 1);
 204:	83 ec 04             	sub    $0x4,%esp
 207:	6a 01                	push   $0x1
 209:	8d 45 ef             	lea    -0x11(%ebp),%eax
 20c:	50                   	push   %eax
 20d:	6a 00                	push   $0x0
 20f:	e8 71 01 00 00       	call   385 <read>
 214:	83 c4 10             	add    $0x10,%esp
 217:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 21a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 21e:	7e 33                	jle    253 <gets+0x6a>
      break;
    buf[i++] = c;
 220:	8b 45 f4             	mov    -0xc(%ebp),%eax
 223:	8d 50 01             	lea    0x1(%eax),%edx
 226:	89 55 f4             	mov    %edx,-0xc(%ebp)
 229:	89 c2                	mov    %eax,%edx
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	01 c2                	add    %eax,%edx
 230:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 234:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 236:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 23a:	3c 0a                	cmp    $0xa,%al
 23c:	74 16                	je     254 <gets+0x6b>
 23e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 242:	3c 0d                	cmp    $0xd,%al
 244:	74 0e                	je     254 <gets+0x6b>
  for(i=0; i+1 < max; ){
 246:	8b 45 f4             	mov    -0xc(%ebp),%eax
 249:	83 c0 01             	add    $0x1,%eax
 24c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 24f:	7f b3                	jg     204 <gets+0x1b>
 251:	eb 01                	jmp    254 <gets+0x6b>
      break;
 253:	90                   	nop
      break;
  }
  buf[i] = '\0';
 254:	8b 55 f4             	mov    -0xc(%ebp),%edx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	01 d0                	add    %edx,%eax
 25c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 262:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 265:	c9                   	leave  
 266:	c3                   	ret    

00000267 <stat>:

int
stat(const char *n, struct stat *st)
{
 267:	55                   	push   %ebp
 268:	89 e5                	mov    %esp,%ebp
 26a:	53                   	push   %ebx
 26b:	83 ec 14             	sub    $0x14,%esp
 26e:	e8 2d fe ff ff       	call   a0 <__x86.get_pc_thunk.bx>
 273:	81 c3 6d 09 00 00    	add    $0x96d,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	6a 00                	push   $0x0
 27e:	ff 75 08             	push   0x8(%ebp)
 281:	e8 27 01 00 00       	call   3ad <open>
 286:	83 c4 10             	add    $0x10,%esp
 289:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 28c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 290:	79 07                	jns    299 <stat+0x32>
    return -1;
 292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 297:	eb 25                	jmp    2be <stat+0x57>
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	push   0xc(%ebp)
 29f:	ff 75 f4             	push   -0xc(%ebp)
 2a2:	e8 1e 01 00 00       	call   3c5 <fstat>
 2a7:	83 c4 10             	add    $0x10,%esp
 2aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ad:	83 ec 0c             	sub    $0xc,%esp
 2b0:	ff 75 f4             	push   -0xc(%ebp)
 2b3:	e8 dd 00 00 00       	call   395 <close>
 2b8:	83 c4 10             	add    $0x10,%esp
  return r;
 2bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2c1:	c9                   	leave  
 2c2:	c3                   	ret    

000002c3 <atoi>:

int
atoi(const char *s)
{
 2c3:	55                   	push   %ebp
 2c4:	89 e5                	mov    %esp,%ebp
 2c6:	83 ec 10             	sub    $0x10,%esp
 2c9:	e8 93 00 00 00       	call   361 <__x86.get_pc_thunk.ax>
 2ce:	05 12 09 00 00       	add    $0x912,%eax
  int n;

  n = 0;
 2d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2da:	eb 25                	jmp    301 <atoi+0x3e>
    n = n*10 + *s++ - '0';
 2dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2df:	89 d0                	mov    %edx,%eax
 2e1:	c1 e0 02             	shl    $0x2,%eax
 2e4:	01 d0                	add    %edx,%eax
 2e6:	01 c0                	add    %eax,%eax
 2e8:	89 c1                	mov    %eax,%ecx
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	8d 50 01             	lea    0x1(%eax),%edx
 2f0:	89 55 08             	mov    %edx,0x8(%ebp)
 2f3:	0f b6 00             	movzbl (%eax),%eax
 2f6:	0f be c0             	movsbl %al,%eax
 2f9:	01 c8                	add    %ecx,%eax
 2fb:	83 e8 30             	sub    $0x30,%eax
 2fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	0f b6 00             	movzbl (%eax),%eax
 307:	3c 2f                	cmp    $0x2f,%al
 309:	7e 0a                	jle    315 <atoi+0x52>
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	0f b6 00             	movzbl (%eax),%eax
 311:	3c 39                	cmp    $0x39,%al
 313:	7e c7                	jle    2dc <atoi+0x19>
  return n;
 315:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 318:	c9                   	leave  
 319:	c3                   	ret    

0000031a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 31a:	55                   	push   %ebp
 31b:	89 e5                	mov    %esp,%ebp
 31d:	83 ec 10             	sub    $0x10,%esp
 320:	e8 3c 00 00 00       	call   361 <__x86.get_pc_thunk.ax>
 325:	05 bb 08 00 00       	add    $0x8bb,%eax
  char *dst;
  const char *src;

  dst = vdst;
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 330:	8b 45 0c             	mov    0xc(%ebp),%eax
 333:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 336:	eb 17                	jmp    34f <memmove+0x35>
    *dst++ = *src++;
 338:	8b 55 f8             	mov    -0x8(%ebp),%edx
 33b:	8d 42 01             	lea    0x1(%edx),%eax
 33e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 341:	8b 45 fc             	mov    -0x4(%ebp),%eax
 344:	8d 48 01             	lea    0x1(%eax),%ecx
 347:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 34a:	0f b6 12             	movzbl (%edx),%edx
 34d:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 34f:	8b 45 10             	mov    0x10(%ebp),%eax
 352:	8d 50 ff             	lea    -0x1(%eax),%edx
 355:	89 55 10             	mov    %edx,0x10(%ebp)
 358:	85 c0                	test   %eax,%eax
 35a:	7f dc                	jg     338 <memmove+0x1e>
  return vdst;
 35c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 35f:	c9                   	leave  
 360:	c3                   	ret    

00000361 <__x86.get_pc_thunk.ax>:
 361:	8b 04 24             	mov    (%esp),%eax
 364:	c3                   	ret    

00000365 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 365:	b8 01 00 00 00       	mov    $0x1,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <exit>:
SYSCALL(exit)
 36d:	b8 02 00 00 00       	mov    $0x2,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <wait>:
SYSCALL(wait)
 375:	b8 03 00 00 00       	mov    $0x3,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <pipe>:
SYSCALL(pipe)
 37d:	b8 04 00 00 00       	mov    $0x4,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <read>:
SYSCALL(read)
 385:	b8 05 00 00 00       	mov    $0x5,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <write>:
SYSCALL(write)
 38d:	b8 10 00 00 00       	mov    $0x10,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <close>:
SYSCALL(close)
 395:	b8 15 00 00 00       	mov    $0x15,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <kill>:
SYSCALL(kill)
 39d:	b8 06 00 00 00       	mov    $0x6,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <exec>:
SYSCALL(exec)
 3a5:	b8 07 00 00 00       	mov    $0x7,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <open>:
SYSCALL(open)
 3ad:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <mknod>:
SYSCALL(mknod)
 3b5:	b8 11 00 00 00       	mov    $0x11,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <unlink>:
SYSCALL(unlink)
 3bd:	b8 12 00 00 00       	mov    $0x12,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <fstat>:
SYSCALL(fstat)
 3c5:	b8 08 00 00 00       	mov    $0x8,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <link>:
SYSCALL(link)
 3cd:	b8 13 00 00 00       	mov    $0x13,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <mkdir>:
SYSCALL(mkdir)
 3d5:	b8 14 00 00 00       	mov    $0x14,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <chdir>:
SYSCALL(chdir)
 3dd:	b8 09 00 00 00       	mov    $0x9,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <dup>:
SYSCALL(dup)
 3e5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <getpid>:
SYSCALL(getpid)
 3ed:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <sbrk>:
SYSCALL(sbrk)
 3f5:	b8 0c 00 00 00       	mov    $0xc,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <sleep>:
SYSCALL(sleep)
 3fd:	b8 0d 00 00 00       	mov    $0xd,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <uptime>:
SYSCALL(uptime)
 405:	b8 0e 00 00 00       	mov    $0xe,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <random>:
SYSCALL(random)
 40d:	b8 16 00 00 00       	mov    $0x16,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	53                   	push   %ebx
 419:	83 ec 14             	sub    $0x14,%esp
 41c:	e8 40 ff ff ff       	call   361 <__x86.get_pc_thunk.ax>
 421:	05 bf 07 00 00       	add    $0x7bf,%eax
 426:	8b 55 0c             	mov    0xc(%ebp),%edx
 429:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 42c:	83 ec 04             	sub    $0x4,%esp
 42f:	6a 01                	push   $0x1
 431:	8d 55 f4             	lea    -0xc(%ebp),%edx
 434:	52                   	push   %edx
 435:	ff 75 08             	push   0x8(%ebp)
 438:	89 c3                	mov    %eax,%ebx
 43a:	e8 4e ff ff ff       	call   38d <write>
 43f:	83 c4 10             	add    $0x10,%esp
}
 442:	90                   	nop
 443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 446:	c9                   	leave  
 447:	c3                   	ret    

00000448 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	53                   	push   %ebx
 44c:	83 ec 24             	sub    $0x24,%esp
 44f:	e8 58 02 00 00       	call   6ac <__x86.get_pc_thunk.cx>
 454:	81 c1 8c 07 00 00    	add    $0x78c,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 45a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 461:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 465:	74 17                	je     47e <printint+0x36>
 467:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 46b:	79 11                	jns    47e <printint+0x36>
    neg = 1;
 46d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 474:	8b 45 0c             	mov    0xc(%ebp),%eax
 477:	f7 d8                	neg    %eax
 479:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47c:	eb 06                	jmp    484 <printint+0x3c>
  } else {
    x = xx;
 47e:	8b 45 0c             	mov    0xc(%ebp),%eax
 481:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 484:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 48b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 48e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 491:	ba 00 00 00 00       	mov    $0x0,%edx
 496:	f7 f3                	div    %ebx
 498:	89 d3                	mov    %edx,%ebx
 49a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49d:	8d 50 01             	lea    0x1(%eax),%edx
 4a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a3:	0f b6 94 19 0c 00 00 	movzbl 0xc(%ecx,%ebx,1),%edx
 4aa:	00 
 4ab:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4af:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4b5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ba:	f7 f3                	div    %ebx
 4bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4c3:	75 c6                	jne    48b <printint+0x43>
  if(neg)
 4c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4c9:	74 2d                	je     4f8 <printint+0xb0>
    buf[i++] = '-';
 4cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ce:	8d 50 01             	lea    0x1(%eax),%edx
 4d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4d4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4d9:	eb 1d                	jmp    4f8 <printint+0xb0>
    putc(fd, buf[i]);
 4db:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e1:	01 d0                	add    %edx,%eax
 4e3:	0f b6 00             	movzbl (%eax),%eax
 4e6:	0f be c0             	movsbl %al,%eax
 4e9:	83 ec 08             	sub    $0x8,%esp
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	push   0x8(%ebp)
 4f0:	e8 20 ff ff ff       	call   415 <putc>
 4f5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4f8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 500:	79 d9                	jns    4db <printint+0x93>
}
 502:	90                   	nop
 503:	90                   	nop
 504:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 507:	c9                   	leave  
 508:	c3                   	ret    

00000509 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 509:	55                   	push   %ebp
 50a:	89 e5                	mov    %esp,%ebp
 50c:	53                   	push   %ebx
 50d:	83 ec 24             	sub    $0x24,%esp
 510:	e8 8b fb ff ff       	call   a0 <__x86.get_pc_thunk.bx>
 515:	81 c3 cb 06 00 00    	add    $0x6cb,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 51b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 522:	8d 45 0c             	lea    0xc(%ebp),%eax
 525:	83 c0 04             	add    $0x4,%eax
 528:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 52b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 532:	e9 5b 01 00 00       	jmp    692 <printf+0x189>
    c = fmt[i] & 0xff;
 537:	8b 55 0c             	mov    0xc(%ebp),%edx
 53a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 53d:	01 d0                	add    %edx,%eax
 53f:	0f b6 00             	movzbl (%eax),%eax
 542:	0f be c0             	movsbl %al,%eax
 545:	25 ff 00 00 00       	and    $0xff,%eax
 54a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 54d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 551:	75 2c                	jne    57f <printf+0x76>
      if(c == '%'){
 553:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 557:	75 0c                	jne    565 <printf+0x5c>
        state = '%';
 559:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 560:	e9 29 01 00 00       	jmp    68e <printf+0x185>
      } else {
        putc(fd, c);
 565:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 568:	0f be c0             	movsbl %al,%eax
 56b:	83 ec 08             	sub    $0x8,%esp
 56e:	50                   	push   %eax
 56f:	ff 75 08             	push   0x8(%ebp)
 572:	e8 9e fe ff ff       	call   415 <putc>
 577:	83 c4 10             	add    $0x10,%esp
 57a:	e9 0f 01 00 00       	jmp    68e <printf+0x185>
      }
    } else if(state == '%'){
 57f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 583:	0f 85 05 01 00 00    	jne    68e <printf+0x185>
      if(c == 'd'){
 589:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 58d:	75 1e                	jne    5ad <printf+0xa4>
        printint(fd, *ap, 10, 1);
 58f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 592:	8b 00                	mov    (%eax),%eax
 594:	6a 01                	push   $0x1
 596:	6a 0a                	push   $0xa
 598:	50                   	push   %eax
 599:	ff 75 08             	push   0x8(%ebp)
 59c:	e8 a7 fe ff ff       	call   448 <printint>
 5a1:	83 c4 10             	add    $0x10,%esp
        ap++;
 5a4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a8:	e9 da 00 00 00       	jmp    687 <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
 5ad:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5b1:	74 06                	je     5b9 <printf+0xb0>
 5b3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5b7:	75 1e                	jne    5d7 <printf+0xce>
        printint(fd, *ap, 16, 0);
 5b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bc:	8b 00                	mov    (%eax),%eax
 5be:	6a 00                	push   $0x0
 5c0:	6a 10                	push   $0x10
 5c2:	50                   	push   %eax
 5c3:	ff 75 08             	push   0x8(%ebp)
 5c6:	e8 7d fe ff ff       	call   448 <printint>
 5cb:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d2:	e9 b0 00 00 00       	jmp    687 <printf+0x17e>
      } else if(c == 's'){
 5d7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5db:	75 45                	jne    622 <printf+0x119>
        s = (char*)*ap;
 5dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e0:	8b 00                	mov    (%eax),%eax
 5e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ed:	75 27                	jne    616 <printf+0x10d>
          s = "(null)";
 5ef:	8d 83 55 fd ff ff    	lea    -0x2ab(%ebx),%eax
 5f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
 5f8:	eb 1c                	jmp    616 <printf+0x10d>
          putc(fd, *s);
 5fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5fd:	0f b6 00             	movzbl (%eax),%eax
 600:	0f be c0             	movsbl %al,%eax
 603:	83 ec 08             	sub    $0x8,%esp
 606:	50                   	push   %eax
 607:	ff 75 08             	push   0x8(%ebp)
 60a:	e8 06 fe ff ff       	call   415 <putc>
 60f:	83 c4 10             	add    $0x10,%esp
          s++;
 612:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 616:	8b 45 f4             	mov    -0xc(%ebp),%eax
 619:	0f b6 00             	movzbl (%eax),%eax
 61c:	84 c0                	test   %al,%al
 61e:	75 da                	jne    5fa <printf+0xf1>
 620:	eb 65                	jmp    687 <printf+0x17e>
        }
      } else if(c == 'c'){
 622:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 626:	75 1d                	jne    645 <printf+0x13c>
        putc(fd, *ap);
 628:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62b:	8b 00                	mov    (%eax),%eax
 62d:	0f be c0             	movsbl %al,%eax
 630:	83 ec 08             	sub    $0x8,%esp
 633:	50                   	push   %eax
 634:	ff 75 08             	push   0x8(%ebp)
 637:	e8 d9 fd ff ff       	call   415 <putc>
 63c:	83 c4 10             	add    $0x10,%esp
        ap++;
 63f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 643:	eb 42                	jmp    687 <printf+0x17e>
      } else if(c == '%'){
 645:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 649:	75 17                	jne    662 <printf+0x159>
        putc(fd, c);
 64b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	83 ec 08             	sub    $0x8,%esp
 654:	50                   	push   %eax
 655:	ff 75 08             	push   0x8(%ebp)
 658:	e8 b8 fd ff ff       	call   415 <putc>
 65d:	83 c4 10             	add    $0x10,%esp
 660:	eb 25                	jmp    687 <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 662:	83 ec 08             	sub    $0x8,%esp
 665:	6a 25                	push   $0x25
 667:	ff 75 08             	push   0x8(%ebp)
 66a:	e8 a6 fd ff ff       	call   415 <putc>
 66f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 672:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 675:	0f be c0             	movsbl %al,%eax
 678:	83 ec 08             	sub    $0x8,%esp
 67b:	50                   	push   %eax
 67c:	ff 75 08             	push   0x8(%ebp)
 67f:	e8 91 fd ff ff       	call   415 <putc>
 684:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 687:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 68e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 692:	8b 55 0c             	mov    0xc(%ebp),%edx
 695:	8b 45 f0             	mov    -0x10(%ebp),%eax
 698:	01 d0                	add    %edx,%eax
 69a:	0f b6 00             	movzbl (%eax),%eax
 69d:	84 c0                	test   %al,%al
 69f:	0f 85 92 fe ff ff    	jne    537 <printf+0x2e>
    }
  }
}
 6a5:	90                   	nop
 6a6:	90                   	nop
 6a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6aa:	c9                   	leave  
 6ab:	c3                   	ret    

000006ac <__x86.get_pc_thunk.cx>:
 6ac:	8b 0c 24             	mov    (%esp),%ecx
 6af:	c3                   	ret    

000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	83 ec 10             	sub    $0x10,%esp
 6b6:	e8 a6 fc ff ff       	call   361 <__x86.get_pc_thunk.ax>
 6bb:	05 25 05 00 00       	add    $0x525,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c0:	8b 55 08             	mov    0x8(%ebp),%edx
 6c3:	83 ea 08             	sub    $0x8,%edx
 6c6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c9:	8b 90 28 00 00 00    	mov    0x28(%eax),%edx
 6cf:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6d2:	eb 24                	jmp    6f8 <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6d7:	8b 12                	mov    (%edx),%edx
 6d9:	39 55 fc             	cmp    %edx,-0x4(%ebp)
 6dc:	72 12                	jb     6f0 <free+0x40>
 6de:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e1:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6e4:	77 24                	ja     70a <free+0x5a>
 6e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6e9:	8b 12                	mov    (%edx),%edx
 6eb:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 6ee:	72 1a                	jb     70a <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 6f3:	8b 12                	mov    (%edx),%edx
 6f5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 6f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6fb:	3b 55 fc             	cmp    -0x4(%ebp),%edx
 6fe:	76 d4                	jbe    6d4 <free+0x24>
 700:	8b 55 fc             	mov    -0x4(%ebp),%edx
 703:	8b 12                	mov    (%edx),%edx
 705:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 708:	73 ca                	jae    6d4 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
 70a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70d:	8b 52 04             	mov    0x4(%edx),%edx
 710:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 717:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71a:	01 d1                	add    %edx,%ecx
 71c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 71f:	8b 12                	mov    (%edx),%edx
 721:	39 d1                	cmp    %edx,%ecx
 723:	75 24                	jne    749 <free+0x99>
    bp->s.size += p->s.ptr->s.size;
 725:	8b 55 f8             	mov    -0x8(%ebp),%edx
 728:	8b 4a 04             	mov    0x4(%edx),%ecx
 72b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 72e:	8b 12                	mov    (%edx),%edx
 730:	8b 52 04             	mov    0x4(%edx),%edx
 733:	01 d1                	add    %edx,%ecx
 735:	8b 55 f8             	mov    -0x8(%ebp),%edx
 738:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
 73b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 73e:	8b 12                	mov    (%edx),%edx
 740:	8b 0a                	mov    (%edx),%ecx
 742:	8b 55 f8             	mov    -0x8(%ebp),%edx
 745:	89 0a                	mov    %ecx,(%edx)
 747:	eb 0a                	jmp    753 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
 749:	8b 55 fc             	mov    -0x4(%ebp),%edx
 74c:	8b 0a                	mov    (%edx),%ecx
 74e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 751:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
 753:	8b 55 fc             	mov    -0x4(%ebp),%edx
 756:	8b 52 04             	mov    0x4(%edx),%edx
 759:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 760:	8b 55 fc             	mov    -0x4(%ebp),%edx
 763:	01 ca                	add    %ecx,%edx
 765:	39 55 f8             	cmp    %edx,-0x8(%ebp)
 768:	75 20                	jne    78a <free+0xda>
    p->s.size += bp->s.size;
 76a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 76d:	8b 4a 04             	mov    0x4(%edx),%ecx
 770:	8b 55 f8             	mov    -0x8(%ebp),%edx
 773:	8b 52 04             	mov    0x4(%edx),%edx
 776:	01 d1                	add    %edx,%ecx
 778:	8b 55 fc             	mov    -0x4(%ebp),%edx
 77b:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 77e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 781:	8b 0a                	mov    (%edx),%ecx
 783:	8b 55 fc             	mov    -0x4(%ebp),%edx
 786:	89 0a                	mov    %ecx,(%edx)
 788:	eb 08                	jmp    792 <free+0xe2>
  } else
    p->s.ptr = bp;
 78a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 78d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
 790:	89 0a                	mov    %ecx,(%edx)
  freep = p;
 792:	8b 55 fc             	mov    -0x4(%ebp),%edx
 795:	89 90 28 00 00 00    	mov    %edx,0x28(%eax)
}
 79b:	90                   	nop
 79c:	c9                   	leave  
 79d:	c3                   	ret    

0000079e <morecore>:

static Header*
morecore(uint nu)
{
 79e:	55                   	push   %ebp
 79f:	89 e5                	mov    %esp,%ebp
 7a1:	53                   	push   %ebx
 7a2:	83 ec 14             	sub    $0x14,%esp
 7a5:	e8 f6 f8 ff ff       	call   a0 <__x86.get_pc_thunk.bx>
 7aa:	81 c3 36 04 00 00    	add    $0x436,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 7b0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7b7:	77 07                	ja     7c0 <morecore+0x22>
    nu = 4096;
 7b9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7c0:	8b 45 08             	mov    0x8(%ebp),%eax
 7c3:	c1 e0 03             	shl    $0x3,%eax
 7c6:	83 ec 0c             	sub    $0xc,%esp
 7c9:	50                   	push   %eax
 7ca:	e8 26 fc ff ff       	call   3f5 <sbrk>
 7cf:	83 c4 10             	add    $0x10,%esp
 7d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7d5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7d9:	75 07                	jne    7e2 <morecore+0x44>
    return 0;
 7db:	b8 00 00 00 00       	mov    $0x0,%eax
 7e0:	eb 27                	jmp    809 <morecore+0x6b>
  hp = (Header*)p;
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	8b 55 08             	mov    0x8(%ebp),%edx
 7ee:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	83 c0 08             	add    $0x8,%eax
 7f7:	83 ec 0c             	sub    $0xc,%esp
 7fa:	50                   	push   %eax
 7fb:	e8 b0 fe ff ff       	call   6b0 <free>
 800:	83 c4 10             	add    $0x10,%esp
  return freep;
 803:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
}
 809:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 80c:	c9                   	leave  
 80d:	c3                   	ret    

0000080e <malloc>:

void*
malloc(uint nbytes)
{
 80e:	55                   	push   %ebp
 80f:	89 e5                	mov    %esp,%ebp
 811:	53                   	push   %ebx
 812:	83 ec 14             	sub    $0x14,%esp
 815:	e8 86 f8 ff ff       	call   a0 <__x86.get_pc_thunk.bx>
 81a:	81 c3 c6 03 00 00    	add    $0x3c6,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 820:	8b 45 08             	mov    0x8(%ebp),%eax
 823:	83 c0 07             	add    $0x7,%eax
 826:	c1 e8 03             	shr    $0x3,%eax
 829:	83 c0 01             	add    $0x1,%eax
 82c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 82f:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 835:	89 45 f0             	mov    %eax,-0x10(%ebp)
 838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 83c:	75 28                	jne    866 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
 83e:	8d 83 20 00 00 00    	lea    0x20(%ebx),%eax
 844:	89 45 f0             	mov    %eax,-0x10(%ebp)
 847:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84a:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
 850:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 856:	89 83 20 00 00 00    	mov    %eax,0x20(%ebx)
    base.s.size = 0;
 85c:	c7 83 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
 863:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	8b 45 f0             	mov    -0x10(%ebp),%eax
 869:	8b 00                	mov    (%eax),%eax
 86b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 871:	8b 40 04             	mov    0x4(%eax),%eax
 874:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 877:	77 4e                	ja     8c7 <malloc+0xb9>
      if(p->s.size == nunits)
 879:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87c:	8b 40 04             	mov    0x4(%eax),%eax
 87f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 882:	75 0c                	jne    890 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
 884:	8b 45 f4             	mov    -0xc(%ebp),%eax
 887:	8b 10                	mov    (%eax),%edx
 889:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88c:	89 10                	mov    %edx,(%eax)
 88e:	eb 26                	jmp    8b6 <malloc+0xa8>
      else {
        p->s.size -= nunits;
 890:	8b 45 f4             	mov    -0xc(%ebp),%eax
 893:	8b 40 04             	mov    0x4(%eax),%eax
 896:	2b 45 ec             	sub    -0x14(%ebp),%eax
 899:	89 c2                	mov    %eax,%edx
 89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a4:	8b 40 04             	mov    0x4(%eax),%eax
 8a7:	c1 e0 03             	shl    $0x3,%eax
 8aa:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b9:	89 83 28 00 00 00    	mov    %eax,0x28(%ebx)
      return (void*)(p + 1);
 8bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c2:	83 c0 08             	add    $0x8,%eax
 8c5:	eb 3c                	jmp    903 <malloc+0xf5>
    }
    if(p == freep)
 8c7:	8b 83 28 00 00 00    	mov    0x28(%ebx),%eax
 8cd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8d0:	75 1e                	jne    8f0 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
 8d2:	83 ec 0c             	sub    $0xc,%esp
 8d5:	ff 75 ec             	push   -0x14(%ebp)
 8d8:	e8 c1 fe ff ff       	call   79e <morecore>
 8dd:	83 c4 10             	add    $0x10,%esp
 8e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8e7:	75 07                	jne    8f0 <malloc+0xe2>
        return 0;
 8e9:	b8 00 00 00 00       	mov    $0x0,%eax
 8ee:	eb 13                	jmp    903 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f9:	8b 00                	mov    (%eax),%eax
 8fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8fe:	e9 6b ff ff ff       	jmp    86e <malloc+0x60>
  }
}
 903:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 906:	c9                   	leave  
 907:	c3                   	ret    
