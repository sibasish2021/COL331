
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 24             	sub    $0x24,%esp
       7:	e8 d7 0d 00 00       	call   de3 <__x86.get_pc_thunk.bx>
       c:	81 c3 64 1c 00 00    	add    $0x1c64,%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
      12:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
      16:	75 05                	jne    1d <runcmd+0x1d>
    exit();
      18:	e8 93 10 00 00       	call   10b0 <exit>

  switch(cmd->type){
      1d:	8b 45 08             	mov    0x8(%ebp),%eax
      20:	8b 00                	mov    (%eax),%eax
      22:	83 f8 05             	cmp    $0x5,%eax
      25:	77 0e                	ja     35 <.L3>
      27:	c1 e0 02             	shl    $0x2,%eax
      2a:	8b 84 18 08 fa ff ff 	mov    -0x5f8(%eax,%ebx,1),%eax
      31:	01 d8                	add    %ebx,%eax
      33:	ff e0                	jmp    *%eax

00000035 <.L3>:
  default:
    panic("runcmd");
      35:	83 ec 0c             	sub    $0xc,%esp
      38:	8d 83 dc f9 ff ff    	lea    -0x624(%ebx),%eax
      3e:	50                   	push   %eax
      3f:	e8 9b 03 00 00       	call   3df <panic>
      44:	83 c4 10             	add    $0x10,%esp

00000047 <.L9>:

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      47:	8b 45 08             	mov    0x8(%ebp),%eax
      4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
      4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      50:	8b 40 04             	mov    0x4(%eax),%eax
      53:	85 c0                	test   %eax,%eax
      55:	75 05                	jne    5c <.L9+0x15>
      exit();
      57:	e8 54 10 00 00       	call   10b0 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      5f:	8d 50 04             	lea    0x4(%eax),%edx
      62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 08             	sub    $0x8,%esp
      6b:	52                   	push   %edx
      6c:	50                   	push   %eax
      6d:	e8 76 10 00 00       	call   10e8 <exec>
      72:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      78:	8b 40 04             	mov    0x4(%eax),%eax
      7b:	83 ec 04             	sub    $0x4,%esp
      7e:	50                   	push   %eax
      7f:	8d 83 e3 f9 ff ff    	lea    -0x61d(%ebx),%eax
      85:	50                   	push   %eax
      86:	6a 02                	push   $0x2
      88:	e8 bf 11 00 00       	call   124c <printf>
      8d:	83 c4 10             	add    $0x10,%esp
    break;
      90:	e9 ca 01 00 00       	jmp    25f <.L4+0x22>

00000095 <.L8>:

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      95:	8b 45 08             	mov    0x8(%ebp),%eax
      98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
      9b:	8b 45 e8             	mov    -0x18(%ebp),%eax
      9e:	8b 40 14             	mov    0x14(%eax),%eax
      a1:	83 ec 0c             	sub    $0xc,%esp
      a4:	50                   	push   %eax
      a5:	e8 2e 10 00 00       	call   10d8 <close>
      aa:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b0:	8b 50 10             	mov    0x10(%eax),%edx
      b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b6:	8b 40 08             	mov    0x8(%eax),%eax
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	52                   	push   %edx
      bd:	50                   	push   %eax
      be:	e8 2d 10 00 00       	call   10f0 <open>
      c3:	83 c4 10             	add    $0x10,%esp
      c6:	85 c0                	test   %eax,%eax
      c8:	79 20                	jns    ea <.L8+0x55>
      printf(2, "open %s failed\n", rcmd->file);
      ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
      cd:	8b 40 08             	mov    0x8(%eax),%eax
      d0:	83 ec 04             	sub    $0x4,%esp
      d3:	50                   	push   %eax
      d4:	8d 83 f3 f9 ff ff    	lea    -0x60d(%ebx),%eax
      da:	50                   	push   %eax
      db:	6a 02                	push   $0x2
      dd:	e8 6a 11 00 00       	call   124c <printf>
      e2:	83 c4 10             	add    $0x10,%esp
      exit();
      e5:	e8 c6 0f 00 00       	call   10b0 <exit>
    }
    runcmd(rcmd->cmd);
      ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
      ed:	8b 40 04             	mov    0x4(%eax),%eax
      f0:	83 ec 0c             	sub    $0xc,%esp
      f3:	50                   	push   %eax
      f4:	e8 07 ff ff ff       	call   0 <runcmd>
      f9:	83 c4 10             	add    $0x10,%esp
    break;
      fc:	e9 5e 01 00 00       	jmp    25f <.L4+0x22>

00000101 <.L6>:

  case LIST:
    lcmd = (struct listcmd*)cmd;
     101:	8b 45 08             	mov    0x8(%ebp),%eax
     104:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
     107:	e8 01 03 00 00       	call   40d <fork1>
     10c:	85 c0                	test   %eax,%eax
     10e:	75 12                	jne    122 <.L6+0x21>
      runcmd(lcmd->left);
     110:	8b 45 f0             	mov    -0x10(%ebp),%eax
     113:	8b 40 04             	mov    0x4(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    wait();
     122:	e8 91 0f 00 00       	call   10b8 <wait>
    runcmd(lcmd->right);
     127:	8b 45 f0             	mov    -0x10(%ebp),%eax
     12a:	8b 40 08             	mov    0x8(%eax),%eax
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	50                   	push   %eax
     131:	e8 ca fe ff ff       	call   0 <runcmd>
     136:	83 c4 10             	add    $0x10,%esp
    break;
     139:	e9 21 01 00 00       	jmp    25f <.L4+0x22>

0000013e <.L7>:

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     13e:	8b 45 08             	mov    0x8(%ebp),%eax
     141:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
     144:	83 ec 0c             	sub    $0xc,%esp
     147:	8d 45 dc             	lea    -0x24(%ebp),%eax
     14a:	50                   	push   %eax
     14b:	e8 70 0f 00 00       	call   10c0 <pipe>
     150:	83 c4 10             	add    $0x10,%esp
     153:	85 c0                	test   %eax,%eax
     155:	79 12                	jns    169 <.L7+0x2b>
      panic("pipe");
     157:	83 ec 0c             	sub    $0xc,%esp
     15a:	8d 83 03 fa ff ff    	lea    -0x5fd(%ebx),%eax
     160:	50                   	push   %eax
     161:	e8 79 02 00 00       	call   3df <panic>
     166:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     169:	e8 9f 02 00 00       	call   40d <fork1>
     16e:	85 c0                	test   %eax,%eax
     170:	75 4c                	jne    1be <.L7+0x80>
      close(1);
     172:	83 ec 0c             	sub    $0xc,%esp
     175:	6a 01                	push   $0x1
     177:	e8 5c 0f 00 00       	call   10d8 <close>
     17c:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     17f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     182:	83 ec 0c             	sub    $0xc,%esp
     185:	50                   	push   %eax
     186:	e8 9d 0f 00 00       	call   1128 <dup>
     18b:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     18e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     191:	83 ec 0c             	sub    $0xc,%esp
     194:	50                   	push   %eax
     195:	e8 3e 0f 00 00       	call   10d8 <close>
     19a:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     19d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1a0:	83 ec 0c             	sub    $0xc,%esp
     1a3:	50                   	push   %eax
     1a4:	e8 2f 0f 00 00       	call   10d8 <close>
     1a9:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     1ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1af:	8b 40 04             	mov    0x4(%eax),%eax
     1b2:	83 ec 0c             	sub    $0xc,%esp
     1b5:	50                   	push   %eax
     1b6:	e8 45 fe ff ff       	call   0 <runcmd>
     1bb:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1be:	e8 4a 02 00 00       	call   40d <fork1>
     1c3:	85 c0                	test   %eax,%eax
     1c5:	75 4c                	jne    213 <.L7+0xd5>
      close(0);
     1c7:	83 ec 0c             	sub    $0xc,%esp
     1ca:	6a 00                	push   $0x0
     1cc:	e8 07 0f 00 00       	call   10d8 <close>
     1d1:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1d7:	83 ec 0c             	sub    $0xc,%esp
     1da:	50                   	push   %eax
     1db:	e8 48 0f 00 00       	call   1128 <dup>
     1e0:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1e6:	83 ec 0c             	sub    $0xc,%esp
     1e9:	50                   	push   %eax
     1ea:	e8 e9 0e 00 00       	call   10d8 <close>
     1ef:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1f5:	83 ec 0c             	sub    $0xc,%esp
     1f8:	50                   	push   %eax
     1f9:	e8 da 0e 00 00       	call   10d8 <close>
     1fe:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     201:	8b 45 ec             	mov    -0x14(%ebp),%eax
     204:	8b 40 08             	mov    0x8(%eax),%eax
     207:	83 ec 0c             	sub    $0xc,%esp
     20a:	50                   	push   %eax
     20b:	e8 f0 fd ff ff       	call   0 <runcmd>
     210:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     213:	8b 45 dc             	mov    -0x24(%ebp),%eax
     216:	83 ec 0c             	sub    $0xc,%esp
     219:	50                   	push   %eax
     21a:	e8 b9 0e 00 00       	call   10d8 <close>
     21f:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     222:	8b 45 e0             	mov    -0x20(%ebp),%eax
     225:	83 ec 0c             	sub    $0xc,%esp
     228:	50                   	push   %eax
     229:	e8 aa 0e 00 00       	call   10d8 <close>
     22e:	83 c4 10             	add    $0x10,%esp
    wait();
     231:	e8 82 0e 00 00       	call   10b8 <wait>
    wait();
     236:	e8 7d 0e 00 00       	call   10b8 <wait>
    break;
     23b:	eb 22                	jmp    25f <.L4+0x22>

0000023d <.L4>:

  case BACK:
    bcmd = (struct backcmd*)cmd;
     23d:	8b 45 08             	mov    0x8(%ebp),%eax
     240:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     243:	e8 c5 01 00 00       	call   40d <fork1>
     248:	85 c0                	test   %eax,%eax
     24a:	75 12                	jne    25e <.L4+0x21>
      runcmd(bcmd->cmd);
     24c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     24f:	8b 40 04             	mov    0x4(%eax),%eax
     252:	83 ec 0c             	sub    $0xc,%esp
     255:	50                   	push   %eax
     256:	e8 a5 fd ff ff       	call   0 <runcmd>
     25b:	83 c4 10             	add    $0x10,%esp
    break;
     25e:	90                   	nop
  }
  exit();
     25f:	e8 4c 0e 00 00       	call   10b0 <exit>

00000264 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     264:	55                   	push   %ebp
     265:	89 e5                	mov    %esp,%ebp
     267:	53                   	push   %ebx
     268:	83 ec 04             	sub    $0x4,%esp
     26b:	e8 73 0b 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     270:	81 c3 00 1a 00 00    	add    $0x1a00,%ebx
  printf(2, "$ ");
     276:	83 ec 08             	sub    $0x8,%esp
     279:	8d 83 20 fa ff ff    	lea    -0x5e0(%ebx),%eax
     27f:	50                   	push   %eax
     280:	6a 02                	push   $0x2
     282:	e8 c5 0f 00 00       	call   124c <printf>
     287:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     28a:	8b 45 0c             	mov    0xc(%ebp),%eax
     28d:	83 ec 04             	sub    $0x4,%esp
     290:	50                   	push   %eax
     291:	6a 00                	push   $0x0
     293:	ff 75 08             	push   0x8(%ebp)
     296:	e8 30 0c 00 00       	call   ecb <memset>
     29b:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     29e:	83 ec 08             	sub    $0x8,%esp
     2a1:	ff 75 0c             	push   0xc(%ebp)
     2a4:	ff 75 08             	push   0x8(%ebp)
     2a7:	e8 80 0c 00 00       	call   f2c <gets>
     2ac:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     2af:	8b 45 08             	mov    0x8(%ebp),%eax
     2b2:	0f b6 00             	movzbl (%eax),%eax
     2b5:	84 c0                	test   %al,%al
     2b7:	75 07                	jne    2c0 <getcmd+0x5c>
    return -1;
     2b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2be:	eb 05                	jmp    2c5 <getcmd+0x61>
  return 0;
     2c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2c8:	c9                   	leave  
     2c9:	c3                   	ret    

000002ca <main>:

int
main(void)
{
     2ca:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2ce:	83 e4 f0             	and    $0xfffffff0,%esp
     2d1:	ff 71 fc             	push   -0x4(%ecx)
     2d4:	55                   	push   %ebp
     2d5:	89 e5                	mov    %esp,%ebp
     2d7:	53                   	push   %ebx
     2d8:	51                   	push   %ecx
     2d9:	83 ec 10             	sub    $0x10,%esp
     2dc:	e8 02 0b 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     2e1:	81 c3 8f 19 00 00    	add    $0x198f,%ebx
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     2e7:	eb 16                	jmp    2ff <main+0x35>
    if(fd >= 3){
     2e9:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2ed:	7e 10                	jle    2ff <main+0x35>
      close(fd);
     2ef:	83 ec 0c             	sub    $0xc,%esp
     2f2:	ff 75 f4             	push   -0xc(%ebp)
     2f5:	e8 de 0d 00 00       	call   10d8 <close>
     2fa:	83 c4 10             	add    $0x10,%esp
      break;
     2fd:	eb 1d                	jmp    31c <main+0x52>
  while((fd = open("console", O_RDWR)) >= 0){
     2ff:	83 ec 08             	sub    $0x8,%esp
     302:	6a 02                	push   $0x2
     304:	8d 83 23 fa ff ff    	lea    -0x5dd(%ebx),%eax
     30a:	50                   	push   %eax
     30b:	e8 e0 0d 00 00       	call   10f0 <open>
     310:	83 c4 10             	add    $0x10,%esp
     313:	89 45 f4             	mov    %eax,-0xc(%ebp)
     316:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     31a:	79 cd                	jns    2e9 <main+0x1f>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     31c:	e9 9d 00 00 00       	jmp    3be <main+0xf4>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     321:	0f b6 83 30 00 00 00 	movzbl 0x30(%ebx),%eax
     328:	3c 63                	cmp    $0x63,%al
     32a:	75 66                	jne    392 <main+0xc8>
     32c:	0f b6 83 31 00 00 00 	movzbl 0x31(%ebx),%eax
     333:	3c 64                	cmp    $0x64,%al
     335:	75 5b                	jne    392 <main+0xc8>
     337:	0f b6 83 32 00 00 00 	movzbl 0x32(%ebx),%eax
     33e:	3c 20                	cmp    $0x20,%al
     340:	75 50                	jne    392 <main+0xc8>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     342:	83 ec 0c             	sub    $0xc,%esp
     345:	8d 83 30 00 00 00    	lea    0x30(%ebx),%eax
     34b:	50                   	push   %eax
     34c:	e8 49 0b 00 00       	call   e9a <strlen>
     351:	83 c4 10             	add    $0x10,%esp
     354:	83 e8 01             	sub    $0x1,%eax
     357:	c6 84 03 30 00 00 00 	movb   $0x0,0x30(%ebx,%eax,1)
     35e:	00 
      if(chdir(buf+3) < 0)
     35f:	8d 83 33 00 00 00    	lea    0x33(%ebx),%eax
     365:	83 ec 0c             	sub    $0xc,%esp
     368:	50                   	push   %eax
     369:	e8 b2 0d 00 00       	call   1120 <chdir>
     36e:	83 c4 10             	add    $0x10,%esp
     371:	85 c0                	test   %eax,%eax
     373:	79 49                	jns    3be <main+0xf4>
        printf(2, "cannot cd %s\n", buf+3);
     375:	8d 83 33 00 00 00    	lea    0x33(%ebx),%eax
     37b:	83 ec 04             	sub    $0x4,%esp
     37e:	50                   	push   %eax
     37f:	8d 83 2b fa ff ff    	lea    -0x5d5(%ebx),%eax
     385:	50                   	push   %eax
     386:	6a 02                	push   $0x2
     388:	e8 bf 0e 00 00       	call   124c <printf>
     38d:	83 c4 10             	add    $0x10,%esp
      continue;
     390:	eb 2c                	jmp    3be <main+0xf4>
    }
    if(fork1() == 0)
     392:	e8 76 00 00 00       	call   40d <fork1>
     397:	85 c0                	test   %eax,%eax
     399:	75 1e                	jne    3b9 <main+0xef>
      runcmd(parsecmd(buf));
     39b:	83 ec 0c             	sub    $0xc,%esp
     39e:	8d 83 30 00 00 00    	lea    0x30(%ebx),%eax
     3a4:	50                   	push   %eax
     3a5:	e8 3e 04 00 00       	call   7e8 <parsecmd>
     3aa:	83 c4 10             	add    $0x10,%esp
     3ad:	83 ec 0c             	sub    $0xc,%esp
     3b0:	50                   	push   %eax
     3b1:	e8 4a fc ff ff       	call   0 <runcmd>
     3b6:	83 c4 10             	add    $0x10,%esp
    wait();
     3b9:	e8 fa 0c 00 00       	call   10b8 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     3be:	83 ec 08             	sub    $0x8,%esp
     3c1:	6a 64                	push   $0x64
     3c3:	8d 83 30 00 00 00    	lea    0x30(%ebx),%eax
     3c9:	50                   	push   %eax
     3ca:	e8 95 fe ff ff       	call   264 <getcmd>
     3cf:	83 c4 10             	add    $0x10,%esp
     3d2:	85 c0                	test   %eax,%eax
     3d4:	0f 89 47 ff ff ff    	jns    321 <main+0x57>
  }
  exit();
     3da:	e8 d1 0c 00 00       	call   10b0 <exit>

000003df <panic>:
}

void
panic(char *s)
{
     3df:	55                   	push   %ebp
     3e0:	89 e5                	mov    %esp,%ebp
     3e2:	53                   	push   %ebx
     3e3:	83 ec 04             	sub    $0x4,%esp
     3e6:	e8 f8 09 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     3eb:	81 c3 85 18 00 00    	add    $0x1885,%ebx
  printf(2, "%s\n", s);
     3f1:	83 ec 04             	sub    $0x4,%esp
     3f4:	ff 75 08             	push   0x8(%ebp)
     3f7:	8d 83 39 fa ff ff    	lea    -0x5c7(%ebx),%eax
     3fd:	50                   	push   %eax
     3fe:	6a 02                	push   $0x2
     400:	e8 47 0e 00 00       	call   124c <printf>
     405:	83 c4 10             	add    $0x10,%esp
  exit();
     408:	e8 a3 0c 00 00       	call   10b0 <exit>

0000040d <fork1>:
}

int
fork1(void)
{
     40d:	55                   	push   %ebp
     40e:	89 e5                	mov    %esp,%ebp
     410:	53                   	push   %ebx
     411:	83 ec 14             	sub    $0x14,%esp
     414:	e8 ca 09 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     419:	81 c3 57 18 00 00    	add    $0x1857,%ebx
  int pid;

  pid = fork();
     41f:	e8 84 0c 00 00       	call   10a8 <fork>
     424:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     427:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     42b:	75 12                	jne    43f <fork1+0x32>
    panic("fork");
     42d:	83 ec 0c             	sub    $0xc,%esp
     430:	8d 83 3d fa ff ff    	lea    -0x5c3(%ebx),%eax
     436:	50                   	push   %eax
     437:	e8 a3 ff ff ff       	call   3df <panic>
     43c:	83 c4 10             	add    $0x10,%esp
  return pid;
     43f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     442:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     445:	c9                   	leave  
     446:	c3                   	ret    

00000447 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     447:	55                   	push   %ebp
     448:	89 e5                	mov    %esp,%ebp
     44a:	53                   	push   %ebx
     44b:	83 ec 14             	sub    $0x14,%esp
     44e:	e8 90 09 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     453:	81 c3 1d 18 00 00    	add    $0x181d,%ebx
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     459:	83 ec 0c             	sub    $0xc,%esp
     45c:	6a 54                	push   $0x54
     45e:	e8 ee 10 00 00       	call   1551 <malloc>
     463:	83 c4 10             	add    $0x10,%esp
     466:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     469:	83 ec 04             	sub    $0x4,%esp
     46c:	6a 54                	push   $0x54
     46e:	6a 00                	push   $0x0
     470:	ff 75 f4             	push   -0xc(%ebp)
     473:	e8 53 0a 00 00       	call   ecb <memset>
     478:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     47b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     484:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     48a:	c9                   	leave  
     48b:	c3                   	ret    

0000048c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     48c:	55                   	push   %ebp
     48d:	89 e5                	mov    %esp,%ebp
     48f:	53                   	push   %ebx
     490:	83 ec 14             	sub    $0x14,%esp
     493:	e8 4b 09 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     498:	81 c3 d8 17 00 00    	add    $0x17d8,%ebx
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     49e:	83 ec 0c             	sub    $0xc,%esp
     4a1:	6a 18                	push   $0x18
     4a3:	e8 a9 10 00 00       	call   1551 <malloc>
     4a8:	83 c4 10             	add    $0x10,%esp
     4ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4ae:	83 ec 04             	sub    $0x4,%esp
     4b1:	6a 18                	push   $0x18
     4b3:	6a 00                	push   $0x0
     4b5:	ff 75 f4             	push   -0xc(%ebp)
     4b8:	e8 0e 0a 00 00       	call   ecb <memset>
     4bd:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     4c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c3:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     4c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4cc:	8b 55 08             	mov    0x8(%ebp),%edx
     4cf:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     4d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d5:	8b 55 0c             	mov    0xc(%ebp),%edx
     4d8:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     4db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4de:	8b 55 10             	mov    0x10(%ebp),%edx
     4e1:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     4e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e7:	8b 55 14             	mov    0x14(%ebp),%edx
     4ea:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f0:	8b 55 18             	mov    0x18(%ebp),%edx
     4f3:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     4f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4fc:	c9                   	leave  
     4fd:	c3                   	ret    

000004fe <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4fe:	55                   	push   %ebp
     4ff:	89 e5                	mov    %esp,%ebp
     501:	53                   	push   %ebx
     502:	83 ec 14             	sub    $0x14,%esp
     505:	e8 d9 08 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     50a:	81 c3 66 17 00 00    	add    $0x1766,%ebx
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     510:	83 ec 0c             	sub    $0xc,%esp
     513:	6a 0c                	push   $0xc
     515:	e8 37 10 00 00       	call   1551 <malloc>
     51a:	83 c4 10             	add    $0x10,%esp
     51d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     520:	83 ec 04             	sub    $0x4,%esp
     523:	6a 0c                	push   $0xc
     525:	6a 00                	push   $0x0
     527:	ff 75 f4             	push   -0xc(%ebp)
     52a:	e8 9c 09 00 00       	call   ecb <memset>
     52f:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     532:	8b 45 f4             	mov    -0xc(%ebp),%eax
     535:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     53b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     53e:	8b 55 08             	mov    0x8(%ebp),%edx
     541:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     544:	8b 45 f4             	mov    -0xc(%ebp),%eax
     547:	8b 55 0c             	mov    0xc(%ebp),%edx
     54a:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     550:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     553:	c9                   	leave  
     554:	c3                   	ret    

00000555 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     555:	55                   	push   %ebp
     556:	89 e5                	mov    %esp,%ebp
     558:	53                   	push   %ebx
     559:	83 ec 14             	sub    $0x14,%esp
     55c:	e8 82 08 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     561:	81 c3 0f 17 00 00    	add    $0x170f,%ebx
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     567:	83 ec 0c             	sub    $0xc,%esp
     56a:	6a 0c                	push   $0xc
     56c:	e8 e0 0f 00 00       	call   1551 <malloc>
     571:	83 c4 10             	add    $0x10,%esp
     574:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     577:	83 ec 04             	sub    $0x4,%esp
     57a:	6a 0c                	push   $0xc
     57c:	6a 00                	push   $0x0
     57e:	ff 75 f4             	push   -0xc(%ebp)
     581:	e8 45 09 00 00       	call   ecb <memset>
     586:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     589:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58c:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     592:	8b 45 f4             	mov    -0xc(%ebp),%eax
     595:	8b 55 08             	mov    0x8(%ebp),%edx
     598:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     59b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     59e:	8b 55 0c             	mov    0xc(%ebp),%edx
     5a1:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     5a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5aa:	c9                   	leave  
     5ab:	c3                   	ret    

000005ac <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     5ac:	55                   	push   %ebp
     5ad:	89 e5                	mov    %esp,%ebp
     5af:	53                   	push   %ebx
     5b0:	83 ec 14             	sub    $0x14,%esp
     5b3:	e8 2b 08 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     5b8:	81 c3 b8 16 00 00    	add    $0x16b8,%ebx
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5be:	83 ec 0c             	sub    $0xc,%esp
     5c1:	6a 08                	push   $0x8
     5c3:	e8 89 0f 00 00       	call   1551 <malloc>
     5c8:	83 c4 10             	add    $0x10,%esp
     5cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     5ce:	83 ec 04             	sub    $0x4,%esp
     5d1:	6a 08                	push   $0x8
     5d3:	6a 00                	push   $0x0
     5d5:	ff 75 f4             	push   -0xc(%ebp)
     5d8:	e8 ee 08 00 00       	call   ecb <memset>
     5dd:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     5e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e3:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     5e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ec:	8b 55 08             	mov    0x8(%ebp),%edx
     5ef:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     5f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5f8:	c9                   	leave  
     5f9:	c3                   	ret    

000005fa <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     5fa:	55                   	push   %ebp
     5fb:	89 e5                	mov    %esp,%ebp
     5fd:	53                   	push   %ebx
     5fe:	83 ec 14             	sub    $0x14,%esp
     601:	e8 dd 07 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     606:	81 c3 6a 16 00 00    	add    $0x166a,%ebx
  char *s;
  int ret;

  s = *ps;
     60c:	8b 45 08             	mov    0x8(%ebp),%eax
     60f:	8b 00                	mov    (%eax),%eax
     611:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     614:	eb 04                	jmp    61a <gettoken+0x20>
    s++;
     616:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     61a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     620:	73 20                	jae    642 <gettoken+0x48>
     622:	8b 45 f4             	mov    -0xc(%ebp),%eax
     625:	0f b6 00             	movzbl (%eax),%eax
     628:	0f be c0             	movsbl %al,%eax
     62b:	83 ec 08             	sub    $0x8,%esp
     62e:	50                   	push   %eax
     62f:	8d 83 0c 00 00 00    	lea    0xc(%ebx),%eax
     635:	50                   	push   %eax
     636:	e8 b4 08 00 00       	call   eef <strchr>
     63b:	83 c4 10             	add    $0x10,%esp
     63e:	85 c0                	test   %eax,%eax
     640:	75 d4                	jne    616 <gettoken+0x1c>
  if(q)
     642:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     646:	74 08                	je     650 <gettoken+0x56>
    *q = s;
     648:	8b 45 10             	mov    0x10(%ebp),%eax
     64b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     64e:	89 10                	mov    %edx,(%eax)
  ret = *s;
     650:	8b 45 f4             	mov    -0xc(%ebp),%eax
     653:	0f b6 00             	movzbl (%eax),%eax
     656:	0f be c0             	movsbl %al,%eax
     659:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     65c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65f:	0f b6 00             	movzbl (%eax),%eax
     662:	0f be c0             	movsbl %al,%eax
     665:	83 f8 7c             	cmp    $0x7c,%eax
     668:	74 2c                	je     696 <gettoken+0x9c>
     66a:	83 f8 7c             	cmp    $0x7c,%eax
     66d:	7f 48                	jg     6b7 <gettoken+0xbd>
     66f:	83 f8 3e             	cmp    $0x3e,%eax
     672:	74 28                	je     69c <gettoken+0xa2>
     674:	83 f8 3e             	cmp    $0x3e,%eax
     677:	7f 3e                	jg     6b7 <gettoken+0xbd>
     679:	83 f8 3c             	cmp    $0x3c,%eax
     67c:	7f 39                	jg     6b7 <gettoken+0xbd>
     67e:	83 f8 3b             	cmp    $0x3b,%eax
     681:	7d 13                	jge    696 <gettoken+0x9c>
     683:	83 f8 29             	cmp    $0x29,%eax
     686:	7f 2f                	jg     6b7 <gettoken+0xbd>
     688:	83 f8 28             	cmp    $0x28,%eax
     68b:	7d 09                	jge    696 <gettoken+0x9c>
     68d:	85 c0                	test   %eax,%eax
     68f:	74 7d                	je     70e <gettoken+0x114>
     691:	83 f8 26             	cmp    $0x26,%eax
     694:	75 21                	jne    6b7 <gettoken+0xbd>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     696:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     69a:	eb 79                	jmp    715 <gettoken+0x11b>
  case '>':
    s++;
     69c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     6a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a3:	0f b6 00             	movzbl (%eax),%eax
     6a6:	3c 3e                	cmp    $0x3e,%al
     6a8:	75 67                	jne    711 <gettoken+0x117>
      ret = '+';
     6aa:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     6b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     6b5:	eb 5a                	jmp    711 <gettoken+0x117>
  default:
    ret = 'a';
     6b7:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6be:	eb 04                	jmp    6c4 <gettoken+0xca>
      s++;
     6c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6ca:	73 48                	jae    714 <gettoken+0x11a>
     6cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cf:	0f b6 00             	movzbl (%eax),%eax
     6d2:	0f be c0             	movsbl %al,%eax
     6d5:	83 ec 08             	sub    $0x8,%esp
     6d8:	50                   	push   %eax
     6d9:	8d 83 0c 00 00 00    	lea    0xc(%ebx),%eax
     6df:	50                   	push   %eax
     6e0:	e8 0a 08 00 00       	call   eef <strchr>
     6e5:	83 c4 10             	add    $0x10,%esp
     6e8:	85 c0                	test   %eax,%eax
     6ea:	75 28                	jne    714 <gettoken+0x11a>
     6ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ef:	0f b6 00             	movzbl (%eax),%eax
     6f2:	0f be c0             	movsbl %al,%eax
     6f5:	83 ec 08             	sub    $0x8,%esp
     6f8:	50                   	push   %eax
     6f9:	8d 83 14 00 00 00    	lea    0x14(%ebx),%eax
     6ff:	50                   	push   %eax
     700:	e8 ea 07 00 00       	call   eef <strchr>
     705:	83 c4 10             	add    $0x10,%esp
     708:	85 c0                	test   %eax,%eax
     70a:	74 b4                	je     6c0 <gettoken+0xc6>
    break;
     70c:	eb 06                	jmp    714 <gettoken+0x11a>
    break;
     70e:	90                   	nop
     70f:	eb 04                	jmp    715 <gettoken+0x11b>
    break;
     711:	90                   	nop
     712:	eb 01                	jmp    715 <gettoken+0x11b>
    break;
     714:	90                   	nop
  }
  if(eq)
     715:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     719:	74 0e                	je     729 <gettoken+0x12f>
    *eq = s;
     71b:	8b 45 14             	mov    0x14(%ebp),%eax
     71e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     721:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     723:	eb 04                	jmp    729 <gettoken+0x12f>
    s++;
     725:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     729:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     72f:	73 20                	jae    751 <gettoken+0x157>
     731:	8b 45 f4             	mov    -0xc(%ebp),%eax
     734:	0f b6 00             	movzbl (%eax),%eax
     737:	0f be c0             	movsbl %al,%eax
     73a:	83 ec 08             	sub    $0x8,%esp
     73d:	50                   	push   %eax
     73e:	8d 83 0c 00 00 00    	lea    0xc(%ebx),%eax
     744:	50                   	push   %eax
     745:	e8 a5 07 00 00       	call   eef <strchr>
     74a:	83 c4 10             	add    $0x10,%esp
     74d:	85 c0                	test   %eax,%eax
     74f:	75 d4                	jne    725 <gettoken+0x12b>
  *ps = s;
     751:	8b 45 08             	mov    0x8(%ebp),%eax
     754:	8b 55 f4             	mov    -0xc(%ebp),%edx
     757:	89 10                	mov    %edx,(%eax)
  return ret;
     759:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     75c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     75f:	c9                   	leave  
     760:	c3                   	ret    

00000761 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     761:	55                   	push   %ebp
     762:	89 e5                	mov    %esp,%ebp
     764:	53                   	push   %ebx
     765:	83 ec 14             	sub    $0x14,%esp
     768:	e8 76 06 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     76d:	81 c3 03 15 00 00    	add    $0x1503,%ebx
  char *s;

  s = *ps;
     773:	8b 45 08             	mov    0x8(%ebp),%eax
     776:	8b 00                	mov    (%eax),%eax
     778:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     77b:	eb 04                	jmp    781 <peek+0x20>
    s++;
     77d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     781:	8b 45 f4             	mov    -0xc(%ebp),%eax
     784:	3b 45 0c             	cmp    0xc(%ebp),%eax
     787:	73 20                	jae    7a9 <peek+0x48>
     789:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78c:	0f b6 00             	movzbl (%eax),%eax
     78f:	0f be c0             	movsbl %al,%eax
     792:	83 ec 08             	sub    $0x8,%esp
     795:	50                   	push   %eax
     796:	8d 83 0c 00 00 00    	lea    0xc(%ebx),%eax
     79c:	50                   	push   %eax
     79d:	e8 4d 07 00 00       	call   eef <strchr>
     7a2:	83 c4 10             	add    $0x10,%esp
     7a5:	85 c0                	test   %eax,%eax
     7a7:	75 d4                	jne    77d <peek+0x1c>
  *ps = s;
     7a9:	8b 45 08             	mov    0x8(%ebp),%eax
     7ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7af:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     7b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b4:	0f b6 00             	movzbl (%eax),%eax
     7b7:	84 c0                	test   %al,%al
     7b9:	74 23                	je     7de <peek+0x7d>
     7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7be:	0f b6 00             	movzbl (%eax),%eax
     7c1:	0f be c0             	movsbl %al,%eax
     7c4:	83 ec 08             	sub    $0x8,%esp
     7c7:	50                   	push   %eax
     7c8:	ff 75 10             	push   0x10(%ebp)
     7cb:	e8 1f 07 00 00       	call   eef <strchr>
     7d0:	83 c4 10             	add    $0x10,%esp
     7d3:	85 c0                	test   %eax,%eax
     7d5:	74 07                	je     7de <peek+0x7d>
     7d7:	b8 01 00 00 00       	mov    $0x1,%eax
     7dc:	eb 05                	jmp    7e3 <peek+0x82>
     7de:	b8 00 00 00 00       	mov    $0x0,%eax
}
     7e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7e6:	c9                   	leave  
     7e7:	c3                   	ret    

000007e8 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     7e8:	55                   	push   %ebp
     7e9:	89 e5                	mov    %esp,%ebp
     7eb:	56                   	push   %esi
     7ec:	53                   	push   %ebx
     7ed:	83 ec 10             	sub    $0x10,%esp
     7f0:	e8 ee 05 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     7f5:	81 c3 7b 14 00 00    	add    $0x147b,%ebx
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     7fb:	8b 75 08             	mov    0x8(%ebp),%esi
     7fe:	8b 45 08             	mov    0x8(%ebp),%eax
     801:	83 ec 0c             	sub    $0xc,%esp
     804:	50                   	push   %eax
     805:	e8 90 06 00 00       	call   e9a <strlen>
     80a:	83 c4 10             	add    $0x10,%esp
     80d:	01 f0                	add    %esi,%eax
     80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     812:	83 ec 08             	sub    $0x8,%esp
     815:	ff 75 f4             	push   -0xc(%ebp)
     818:	8d 45 08             	lea    0x8(%ebp),%eax
     81b:	50                   	push   %eax
     81c:	e8 69 00 00 00       	call   88a <parseline>
     821:	83 c4 10             	add    $0x10,%esp
     824:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     827:	83 ec 04             	sub    $0x4,%esp
     82a:	8d 83 42 fa ff ff    	lea    -0x5be(%ebx),%eax
     830:	50                   	push   %eax
     831:	ff 75 f4             	push   -0xc(%ebp)
     834:	8d 45 08             	lea    0x8(%ebp),%eax
     837:	50                   	push   %eax
     838:	e8 24 ff ff ff       	call   761 <peek>
     83d:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     840:	8b 45 08             	mov    0x8(%ebp),%eax
     843:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     846:	74 2a                	je     872 <parsecmd+0x8a>
    printf(2, "leftovers: %s\n", s);
     848:	8b 45 08             	mov    0x8(%ebp),%eax
     84b:	83 ec 04             	sub    $0x4,%esp
     84e:	50                   	push   %eax
     84f:	8d 83 43 fa ff ff    	lea    -0x5bd(%ebx),%eax
     855:	50                   	push   %eax
     856:	6a 02                	push   $0x2
     858:	e8 ef 09 00 00       	call   124c <printf>
     85d:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     860:	83 ec 0c             	sub    $0xc,%esp
     863:	8d 83 52 fa ff ff    	lea    -0x5ae(%ebx),%eax
     869:	50                   	push   %eax
     86a:	e8 70 fb ff ff       	call   3df <panic>
     86f:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     872:	83 ec 0c             	sub    $0xc,%esp
     875:	ff 75 f0             	push   -0x10(%ebp)
     878:	e8 56 04 00 00       	call   cd3 <nulterminate>
     87d:	83 c4 10             	add    $0x10,%esp
  return cmd;
     880:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     883:	8d 65 f8             	lea    -0x8(%ebp),%esp
     886:	5b                   	pop    %ebx
     887:	5e                   	pop    %esi
     888:	5d                   	pop    %ebp
     889:	c3                   	ret    

0000088a <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     88a:	55                   	push   %ebp
     88b:	89 e5                	mov    %esp,%ebp
     88d:	53                   	push   %ebx
     88e:	83 ec 14             	sub    $0x14,%esp
     891:	e8 4d 05 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     896:	81 c3 da 13 00 00    	add    $0x13da,%ebx
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     89c:	83 ec 08             	sub    $0x8,%esp
     89f:	ff 75 0c             	push   0xc(%ebp)
     8a2:	ff 75 08             	push   0x8(%ebp)
     8a5:	e8 a0 00 00 00       	call   94a <parsepipe>
     8aa:	83 c4 10             	add    $0x10,%esp
     8ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     8b0:	eb 23                	jmp    8d5 <parseline+0x4b>
    gettoken(ps, es, 0, 0);
     8b2:	6a 00                	push   $0x0
     8b4:	6a 00                	push   $0x0
     8b6:	ff 75 0c             	push   0xc(%ebp)
     8b9:	ff 75 08             	push   0x8(%ebp)
     8bc:	e8 39 fd ff ff       	call   5fa <gettoken>
     8c1:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     8c4:	83 ec 0c             	sub    $0xc,%esp
     8c7:	ff 75 f4             	push   -0xc(%ebp)
     8ca:	e8 dd fc ff ff       	call   5ac <backcmd>
     8cf:	83 c4 10             	add    $0x10,%esp
     8d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     8d5:	83 ec 04             	sub    $0x4,%esp
     8d8:	8d 83 59 fa ff ff    	lea    -0x5a7(%ebx),%eax
     8de:	50                   	push   %eax
     8df:	ff 75 0c             	push   0xc(%ebp)
     8e2:	ff 75 08             	push   0x8(%ebp)
     8e5:	e8 77 fe ff ff       	call   761 <peek>
     8ea:	83 c4 10             	add    $0x10,%esp
     8ed:	85 c0                	test   %eax,%eax
     8ef:	75 c1                	jne    8b2 <parseline+0x28>
  }
  if(peek(ps, es, ";")){
     8f1:	83 ec 04             	sub    $0x4,%esp
     8f4:	8d 83 5b fa ff ff    	lea    -0x5a5(%ebx),%eax
     8fa:	50                   	push   %eax
     8fb:	ff 75 0c             	push   0xc(%ebp)
     8fe:	ff 75 08             	push   0x8(%ebp)
     901:	e8 5b fe ff ff       	call   761 <peek>
     906:	83 c4 10             	add    $0x10,%esp
     909:	85 c0                	test   %eax,%eax
     90b:	74 35                	je     942 <parseline+0xb8>
    gettoken(ps, es, 0, 0);
     90d:	6a 00                	push   $0x0
     90f:	6a 00                	push   $0x0
     911:	ff 75 0c             	push   0xc(%ebp)
     914:	ff 75 08             	push   0x8(%ebp)
     917:	e8 de fc ff ff       	call   5fa <gettoken>
     91c:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     91f:	83 ec 08             	sub    $0x8,%esp
     922:	ff 75 0c             	push   0xc(%ebp)
     925:	ff 75 08             	push   0x8(%ebp)
     928:	e8 5d ff ff ff       	call   88a <parseline>
     92d:	83 c4 10             	add    $0x10,%esp
     930:	83 ec 08             	sub    $0x8,%esp
     933:	50                   	push   %eax
     934:	ff 75 f4             	push   -0xc(%ebp)
     937:	e8 19 fc ff ff       	call   555 <listcmd>
     93c:	83 c4 10             	add    $0x10,%esp
     93f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     942:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     945:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     948:	c9                   	leave  
     949:	c3                   	ret    

0000094a <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     94a:	55                   	push   %ebp
     94b:	89 e5                	mov    %esp,%ebp
     94d:	53                   	push   %ebx
     94e:	83 ec 14             	sub    $0x14,%esp
     951:	e8 8d 04 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     956:	81 c3 1a 13 00 00    	add    $0x131a,%ebx
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     95c:	83 ec 08             	sub    $0x8,%esp
     95f:	ff 75 0c             	push   0xc(%ebp)
     962:	ff 75 08             	push   0x8(%ebp)
     965:	e8 1f 02 00 00       	call   b89 <parseexec>
     96a:	83 c4 10             	add    $0x10,%esp
     96d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     970:	83 ec 04             	sub    $0x4,%esp
     973:	8d 83 5d fa ff ff    	lea    -0x5a3(%ebx),%eax
     979:	50                   	push   %eax
     97a:	ff 75 0c             	push   0xc(%ebp)
     97d:	ff 75 08             	push   0x8(%ebp)
     980:	e8 dc fd ff ff       	call   761 <peek>
     985:	83 c4 10             	add    $0x10,%esp
     988:	85 c0                	test   %eax,%eax
     98a:	74 35                	je     9c1 <parsepipe+0x77>
    gettoken(ps, es, 0, 0);
     98c:	6a 00                	push   $0x0
     98e:	6a 00                	push   $0x0
     990:	ff 75 0c             	push   0xc(%ebp)
     993:	ff 75 08             	push   0x8(%ebp)
     996:	e8 5f fc ff ff       	call   5fa <gettoken>
     99b:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     99e:	83 ec 08             	sub    $0x8,%esp
     9a1:	ff 75 0c             	push   0xc(%ebp)
     9a4:	ff 75 08             	push   0x8(%ebp)
     9a7:	e8 9e ff ff ff       	call   94a <parsepipe>
     9ac:	83 c4 10             	add    $0x10,%esp
     9af:	83 ec 08             	sub    $0x8,%esp
     9b2:	50                   	push   %eax
     9b3:	ff 75 f4             	push   -0xc(%ebp)
     9b6:	e8 43 fb ff ff       	call   4fe <pipecmd>
     9bb:	83 c4 10             	add    $0x10,%esp
     9be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     9c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     9c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9c7:	c9                   	leave  
     9c8:	c3                   	ret    

000009c9 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9c9:	55                   	push   %ebp
     9ca:	89 e5                	mov    %esp,%ebp
     9cc:	53                   	push   %ebx
     9cd:	83 ec 14             	sub    $0x14,%esp
     9d0:	e8 0e 04 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     9d5:	81 c3 9b 12 00 00    	add    $0x129b,%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9db:	e9 bc 00 00 00       	jmp    a9c <parseredirs+0xd3>
    tok = gettoken(ps, es, 0, 0);
     9e0:	6a 00                	push   $0x0
     9e2:	6a 00                	push   $0x0
     9e4:	ff 75 10             	push   0x10(%ebp)
     9e7:	ff 75 0c             	push   0xc(%ebp)
     9ea:	e8 0b fc ff ff       	call   5fa <gettoken>
     9ef:	83 c4 10             	add    $0x10,%esp
     9f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     9f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
     9f8:	50                   	push   %eax
     9f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
     9fc:	50                   	push   %eax
     9fd:	ff 75 10             	push   0x10(%ebp)
     a00:	ff 75 0c             	push   0xc(%ebp)
     a03:	e8 f2 fb ff ff       	call   5fa <gettoken>
     a08:	83 c4 10             	add    $0x10,%esp
     a0b:	83 f8 61             	cmp    $0x61,%eax
     a0e:	74 12                	je     a22 <parseredirs+0x59>
      panic("missing file for redirection");
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	8d 83 5f fa ff ff    	lea    -0x5a1(%ebx),%eax
     a19:	50                   	push   %eax
     a1a:	e8 c0 f9 ff ff       	call   3df <panic>
     a1f:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     a22:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     a26:	74 31                	je     a59 <parseredirs+0x90>
     a28:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     a2c:	7f 6e                	jg     a9c <parseredirs+0xd3>
     a2e:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     a32:	74 47                	je     a7b <parseredirs+0xb2>
     a34:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     a38:	75 62                	jne    a9c <parseredirs+0xd3>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a3a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	6a 00                	push   $0x0
     a45:	6a 00                	push   $0x0
     a47:	52                   	push   %edx
     a48:	50                   	push   %eax
     a49:	ff 75 08             	push   0x8(%ebp)
     a4c:	e8 3b fa ff ff       	call   48c <redircmd>
     a51:	83 c4 20             	add    $0x20,%esp
     a54:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a57:	eb 43                	jmp    a9c <parseredirs+0xd3>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a59:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a5f:	83 ec 0c             	sub    $0xc,%esp
     a62:	6a 01                	push   $0x1
     a64:	68 01 02 00 00       	push   $0x201
     a69:	52                   	push   %edx
     a6a:	50                   	push   %eax
     a6b:	ff 75 08             	push   0x8(%ebp)
     a6e:	e8 19 fa ff ff       	call   48c <redircmd>
     a73:	83 c4 20             	add    $0x20,%esp
     a76:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a79:	eb 21                	jmp    a9c <parseredirs+0xd3>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a7b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a81:	83 ec 0c             	sub    $0xc,%esp
     a84:	6a 01                	push   $0x1
     a86:	68 01 02 00 00       	push   $0x201
     a8b:	52                   	push   %edx
     a8c:	50                   	push   %eax
     a8d:	ff 75 08             	push   0x8(%ebp)
     a90:	e8 f7 f9 ff ff       	call   48c <redircmd>
     a95:	83 c4 20             	add    $0x20,%esp
     a98:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     a9b:	90                   	nop
  while(peek(ps, es, "<>")){
     a9c:	83 ec 04             	sub    $0x4,%esp
     a9f:	8d 83 7c fa ff ff    	lea    -0x584(%ebx),%eax
     aa5:	50                   	push   %eax
     aa6:	ff 75 10             	push   0x10(%ebp)
     aa9:	ff 75 0c             	push   0xc(%ebp)
     aac:	e8 b0 fc ff ff       	call   761 <peek>
     ab1:	83 c4 10             	add    $0x10,%esp
     ab4:	85 c0                	test   %eax,%eax
     ab6:	0f 85 24 ff ff ff    	jne    9e0 <parseredirs+0x17>
    }
  }
  return cmd;
     abc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     abf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ac2:	c9                   	leave  
     ac3:	c3                   	ret    

00000ac4 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     ac4:	55                   	push   %ebp
     ac5:	89 e5                	mov    %esp,%ebp
     ac7:	53                   	push   %ebx
     ac8:	83 ec 14             	sub    $0x14,%esp
     acb:	e8 13 03 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     ad0:	81 c3 a0 11 00 00    	add    $0x11a0,%ebx
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     ad6:	83 ec 04             	sub    $0x4,%esp
     ad9:	8d 83 7f fa ff ff    	lea    -0x581(%ebx),%eax
     adf:	50                   	push   %eax
     ae0:	ff 75 0c             	push   0xc(%ebp)
     ae3:	ff 75 08             	push   0x8(%ebp)
     ae6:	e8 76 fc ff ff       	call   761 <peek>
     aeb:	83 c4 10             	add    $0x10,%esp
     aee:	85 c0                	test   %eax,%eax
     af0:	75 12                	jne    b04 <parseblock+0x40>
    panic("parseblock");
     af2:	83 ec 0c             	sub    $0xc,%esp
     af5:	8d 83 81 fa ff ff    	lea    -0x57f(%ebx),%eax
     afb:	50                   	push   %eax
     afc:	e8 de f8 ff ff       	call   3df <panic>
     b01:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     b04:	6a 00                	push   $0x0
     b06:	6a 00                	push   $0x0
     b08:	ff 75 0c             	push   0xc(%ebp)
     b0b:	ff 75 08             	push   0x8(%ebp)
     b0e:	e8 e7 fa ff ff       	call   5fa <gettoken>
     b13:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     b16:	83 ec 08             	sub    $0x8,%esp
     b19:	ff 75 0c             	push   0xc(%ebp)
     b1c:	ff 75 08             	push   0x8(%ebp)
     b1f:	e8 66 fd ff ff       	call   88a <parseline>
     b24:	83 c4 10             	add    $0x10,%esp
     b27:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     b2a:	83 ec 04             	sub    $0x4,%esp
     b2d:	8d 83 8c fa ff ff    	lea    -0x574(%ebx),%eax
     b33:	50                   	push   %eax
     b34:	ff 75 0c             	push   0xc(%ebp)
     b37:	ff 75 08             	push   0x8(%ebp)
     b3a:	e8 22 fc ff ff       	call   761 <peek>
     b3f:	83 c4 10             	add    $0x10,%esp
     b42:	85 c0                	test   %eax,%eax
     b44:	75 12                	jne    b58 <parseblock+0x94>
    panic("syntax - missing )");
     b46:	83 ec 0c             	sub    $0xc,%esp
     b49:	8d 83 8e fa ff ff    	lea    -0x572(%ebx),%eax
     b4f:	50                   	push   %eax
     b50:	e8 8a f8 ff ff       	call   3df <panic>
     b55:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     b58:	6a 00                	push   $0x0
     b5a:	6a 00                	push   $0x0
     b5c:	ff 75 0c             	push   0xc(%ebp)
     b5f:	ff 75 08             	push   0x8(%ebp)
     b62:	e8 93 fa ff ff       	call   5fa <gettoken>
     b67:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     b6a:	83 ec 04             	sub    $0x4,%esp
     b6d:	ff 75 0c             	push   0xc(%ebp)
     b70:	ff 75 08             	push   0x8(%ebp)
     b73:	ff 75 f4             	push   -0xc(%ebp)
     b76:	e8 4e fe ff ff       	call   9c9 <parseredirs>
     b7b:	83 c4 10             	add    $0x10,%esp
     b7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     b81:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b87:	c9                   	leave  
     b88:	c3                   	ret    

00000b89 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     b89:	55                   	push   %ebp
     b8a:	89 e5                	mov    %esp,%ebp
     b8c:	53                   	push   %ebx
     b8d:	83 ec 24             	sub    $0x24,%esp
     b90:	e8 4e 02 00 00       	call   de3 <__x86.get_pc_thunk.bx>
     b95:	81 c3 db 10 00 00    	add    $0x10db,%ebx
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     b9b:	83 ec 04             	sub    $0x4,%esp
     b9e:	8d 83 7f fa ff ff    	lea    -0x581(%ebx),%eax
     ba4:	50                   	push   %eax
     ba5:	ff 75 0c             	push   0xc(%ebp)
     ba8:	ff 75 08             	push   0x8(%ebp)
     bab:	e8 b1 fb ff ff       	call   761 <peek>
     bb0:	83 c4 10             	add    $0x10,%esp
     bb3:	85 c0                	test   %eax,%eax
     bb5:	74 16                	je     bcd <parseexec+0x44>
    return parseblock(ps, es);
     bb7:	83 ec 08             	sub    $0x8,%esp
     bba:	ff 75 0c             	push   0xc(%ebp)
     bbd:	ff 75 08             	push   0x8(%ebp)
     bc0:	e8 ff fe ff ff       	call   ac4 <parseblock>
     bc5:	83 c4 10             	add    $0x10,%esp
     bc8:	e9 01 01 00 00       	jmp    cce <parseexec+0x145>

  ret = execcmd();
     bcd:	e8 75 f8 ff ff       	call   447 <execcmd>
     bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     bd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd8:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     bdb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     be2:	83 ec 04             	sub    $0x4,%esp
     be5:	ff 75 0c             	push   0xc(%ebp)
     be8:	ff 75 08             	push   0x8(%ebp)
     beb:	ff 75 f0             	push   -0x10(%ebp)
     bee:	e8 d6 fd ff ff       	call   9c9 <parseredirs>
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     bf9:	e9 8b 00 00 00       	jmp    c89 <parseexec+0x100>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     bfe:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c01:	50                   	push   %eax
     c02:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     c05:	50                   	push   %eax
     c06:	ff 75 0c             	push   0xc(%ebp)
     c09:	ff 75 08             	push   0x8(%ebp)
     c0c:	e8 e9 f9 ff ff       	call   5fa <gettoken>
     c11:	83 c4 10             	add    $0x10,%esp
     c14:	89 45 e8             	mov    %eax,-0x18(%ebp)
     c17:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c1b:	0f 84 8a 00 00 00    	je     cab <parseexec+0x122>
      break;
    if(tok != 'a')
     c21:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     c25:	74 12                	je     c39 <parseexec+0xb0>
      panic("syntax");
     c27:	83 ec 0c             	sub    $0xc,%esp
     c2a:	8d 83 52 fa ff ff    	lea    -0x5ae(%ebx),%eax
     c30:	50                   	push   %eax
     c31:	e8 a9 f7 ff ff       	call   3df <panic>
     c36:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     c39:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     c3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c42:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     c46:	8b 55 e0             	mov    -0x20(%ebp),%edx
     c49:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c4c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c4f:	83 c1 08             	add    $0x8,%ecx
     c52:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     c56:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     c5a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     c5e:	7e 12                	jle    c72 <parseexec+0xe9>
      panic("too many args");
     c60:	83 ec 0c             	sub    $0xc,%esp
     c63:	8d 83 a1 fa ff ff    	lea    -0x55f(%ebx),%eax
     c69:	50                   	push   %eax
     c6a:	e8 70 f7 ff ff       	call   3df <panic>
     c6f:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     c72:	83 ec 04             	sub    $0x4,%esp
     c75:	ff 75 0c             	push   0xc(%ebp)
     c78:	ff 75 08             	push   0x8(%ebp)
     c7b:	ff 75 f0             	push   -0x10(%ebp)
     c7e:	e8 46 fd ff ff       	call   9c9 <parseredirs>
     c83:	83 c4 10             	add    $0x10,%esp
     c86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     c89:	83 ec 04             	sub    $0x4,%esp
     c8c:	8d 83 af fa ff ff    	lea    -0x551(%ebx),%eax
     c92:	50                   	push   %eax
     c93:	ff 75 0c             	push   0xc(%ebp)
     c96:	ff 75 08             	push   0x8(%ebp)
     c99:	e8 c3 fa ff ff       	call   761 <peek>
     c9e:	83 c4 10             	add    $0x10,%esp
     ca1:	85 c0                	test   %eax,%eax
     ca3:	0f 84 55 ff ff ff    	je     bfe <parseexec+0x75>
     ca9:	eb 01                	jmp    cac <parseexec+0x123>
      break;
     cab:	90                   	nop
  }
  cmd->argv[argc] = 0;
     cac:	8b 45 ec             	mov    -0x14(%ebp),%eax
     caf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cb2:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     cb9:	00 
  cmd->eargv[argc] = 0;
     cba:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cc0:	83 c2 08             	add    $0x8,%edx
     cc3:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     cca:	00 
  return ret;
     ccb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     cce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cd1:	c9                   	leave  
     cd2:	c3                   	ret    

00000cd3 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     cd3:	55                   	push   %ebp
     cd4:	89 e5                	mov    %esp,%ebp
     cd6:	83 ec 28             	sub    $0x28,%esp
     cd9:	e8 01 01 00 00       	call   ddf <__x86.get_pc_thunk.dx>
     cde:	81 c2 92 0f 00 00    	add    $0xf92,%edx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     ce4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     ce8:	75 0a                	jne    cf4 <nulterminate+0x21>
    return 0;
     cea:	b8 00 00 00 00       	mov    $0x0,%eax
     cef:	e9 e9 00 00 00       	jmp    ddd <.L110+0x3>

  switch(cmd->type){
     cf4:	8b 45 08             	mov    0x8(%ebp),%eax
     cf7:	8b 00                	mov    (%eax),%eax
     cf9:	83 f8 05             	cmp    $0x5,%eax
     cfc:	0f 87 d8 00 00 00    	ja     dda <.L110>
     d02:	c1 e0 02             	shl    $0x2,%eax
     d05:	8b 84 10 b4 fa ff ff 	mov    -0x54c(%eax,%edx,1),%eax
     d0c:	01 d0                	add    %edx,%eax
     d0e:	ff e0                	jmp    *%eax

00000d10 <.L116>:
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     d16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d1d:	eb 14                	jmp    d33 <.L116+0x23>
      *ecmd->eargv[i] = 0;
     d1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d22:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d25:	83 c2 08             	add    $0x8,%edx
     d28:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     d2c:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     d2f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d33:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d36:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d39:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     d3d:	85 c0                	test   %eax,%eax
     d3f:	75 de                	jne    d1f <.L116+0xf>
    break;
     d41:	e9 94 00 00 00       	jmp    dda <.L110>

00000d46 <.L115>:

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d46:	8b 45 08             	mov    0x8(%ebp),%eax
     d49:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
     d4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d4f:	8b 40 04             	mov    0x4(%eax),%eax
     d52:	83 ec 0c             	sub    $0xc,%esp
     d55:	50                   	push   %eax
     d56:	e8 78 ff ff ff       	call   cd3 <nulterminate>
     d5b:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     d5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d61:	8b 40 0c             	mov    0xc(%eax),%eax
     d64:	c6 00 00             	movb   $0x0,(%eax)
    break;
     d67:	eb 71                	jmp    dda <.L110>

00000d69 <.L114>:

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d69:	8b 45 08             	mov    0x8(%ebp),%eax
     d6c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     d6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d72:	8b 40 04             	mov    0x4(%eax),%eax
     d75:	83 ec 0c             	sub    $0xc,%esp
     d78:	50                   	push   %eax
     d79:	e8 55 ff ff ff       	call   cd3 <nulterminate>
     d7e:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     d81:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d84:	8b 40 08             	mov    0x8(%eax),%eax
     d87:	83 ec 0c             	sub    $0xc,%esp
     d8a:	50                   	push   %eax
     d8b:	e8 43 ff ff ff       	call   cd3 <nulterminate>
     d90:	83 c4 10             	add    $0x10,%esp
    break;
     d93:	eb 45                	jmp    dda <.L110>

00000d95 <.L113>:

  case LIST:
    lcmd = (struct listcmd*)cmd;
     d95:	8b 45 08             	mov    0x8(%ebp),%eax
     d98:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     d9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d9e:	8b 40 04             	mov    0x4(%eax),%eax
     da1:	83 ec 0c             	sub    $0xc,%esp
     da4:	50                   	push   %eax
     da5:	e8 29 ff ff ff       	call   cd3 <nulterminate>
     daa:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     dad:	8b 45 ec             	mov    -0x14(%ebp),%eax
     db0:	8b 40 08             	mov    0x8(%eax),%eax
     db3:	83 ec 0c             	sub    $0xc,%esp
     db6:	50                   	push   %eax
     db7:	e8 17 ff ff ff       	call   cd3 <nulterminate>
     dbc:	83 c4 10             	add    $0x10,%esp
    break;
     dbf:	eb 19                	jmp    dda <.L110>

00000dc1 <.L111>:

  case BACK:
    bcmd = (struct backcmd*)cmd;
     dc1:	8b 45 08             	mov    0x8(%ebp),%eax
     dc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
     dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dca:	8b 40 04             	mov    0x4(%eax),%eax
     dcd:	83 ec 0c             	sub    $0xc,%esp
     dd0:	50                   	push   %eax
     dd1:	e8 fd fe ff ff       	call   cd3 <nulterminate>
     dd6:	83 c4 10             	add    $0x10,%esp
    break;
     dd9:	90                   	nop

00000dda <.L110>:
  }
  return cmd;
     dda:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ddd:	c9                   	leave  
     dde:	c3                   	ret    

00000ddf <__x86.get_pc_thunk.dx>:
     ddf:	8b 14 24             	mov    (%esp),%edx
     de2:	c3                   	ret    

00000de3 <__x86.get_pc_thunk.bx>:
     de3:	8b 1c 24             	mov    (%esp),%ebx
     de6:	c3                   	ret    

00000de7 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     de7:	55                   	push   %ebp
     de8:	89 e5                	mov    %esp,%ebp
     dea:	57                   	push   %edi
     deb:	53                   	push   %ebx
     dec:	e8 b3 02 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     df1:	05 7f 0e 00 00       	add    $0xe7f,%eax
  asm volatile("cld; rep stosb" :
     df6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     df9:	8b 55 10             	mov    0x10(%ebp),%edx
     dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     dff:	89 cb                	mov    %ecx,%ebx
     e01:	89 df                	mov    %ebx,%edi
     e03:	89 d1                	mov    %edx,%ecx
     e05:	fc                   	cld    
     e06:	f3 aa                	rep stos %al,%es:(%edi)
     e08:	89 ca                	mov    %ecx,%edx
     e0a:	89 fb                	mov    %edi,%ebx
     e0c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     e0f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     e12:	90                   	nop
     e13:	5b                   	pop    %ebx
     e14:	5f                   	pop    %edi
     e15:	5d                   	pop    %ebp
     e16:	c3                   	ret    

00000e17 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e17:	55                   	push   %ebp
     e18:	89 e5                	mov    %esp,%ebp
     e1a:	83 ec 10             	sub    $0x10,%esp
     e1d:	e8 82 02 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     e22:	05 4e 0e 00 00       	add    $0xe4e,%eax
  char *os;

  os = s;
     e27:	8b 45 08             	mov    0x8(%ebp),%eax
     e2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     e2d:	90                   	nop
     e2e:	8b 55 0c             	mov    0xc(%ebp),%edx
     e31:	8d 42 01             	lea    0x1(%edx),%eax
     e34:	89 45 0c             	mov    %eax,0xc(%ebp)
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	8d 48 01             	lea    0x1(%eax),%ecx
     e3d:	89 4d 08             	mov    %ecx,0x8(%ebp)
     e40:	0f b6 12             	movzbl (%edx),%edx
     e43:	88 10                	mov    %dl,(%eax)
     e45:	0f b6 00             	movzbl (%eax),%eax
     e48:	84 c0                	test   %al,%al
     e4a:	75 e2                	jne    e2e <strcpy+0x17>
    ;
  return os;
     e4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e4f:	c9                   	leave  
     e50:	c3                   	ret    

00000e51 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e51:	55                   	push   %ebp
     e52:	89 e5                	mov    %esp,%ebp
     e54:	e8 4b 02 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     e59:	05 17 0e 00 00       	add    $0xe17,%eax
  while(*p && *p == *q)
     e5e:	eb 08                	jmp    e68 <strcmp+0x17>
    p++, q++;
     e60:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e64:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	0f b6 00             	movzbl (%eax),%eax
     e6e:	84 c0                	test   %al,%al
     e70:	74 10                	je     e82 <strcmp+0x31>
     e72:	8b 45 08             	mov    0x8(%ebp),%eax
     e75:	0f b6 10             	movzbl (%eax),%edx
     e78:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7b:	0f b6 00             	movzbl (%eax),%eax
     e7e:	38 c2                	cmp    %al,%dl
     e80:	74 de                	je     e60 <strcmp+0xf>
  return (uchar)*p - (uchar)*q;
     e82:	8b 45 08             	mov    0x8(%ebp),%eax
     e85:	0f b6 00             	movzbl (%eax),%eax
     e88:	0f b6 d0             	movzbl %al,%edx
     e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8e:	0f b6 00             	movzbl (%eax),%eax
     e91:	0f b6 c8             	movzbl %al,%ecx
     e94:	89 d0                	mov    %edx,%eax
     e96:	29 c8                	sub    %ecx,%eax
}
     e98:	5d                   	pop    %ebp
     e99:	c3                   	ret    

00000e9a <strlen>:

uint
strlen(const char *s)
{
     e9a:	55                   	push   %ebp
     e9b:	89 e5                	mov    %esp,%ebp
     e9d:	83 ec 10             	sub    $0x10,%esp
     ea0:	e8 ff 01 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     ea5:	05 cb 0d 00 00       	add    $0xdcb,%eax
  int n;

  for(n = 0; s[n]; n++)
     eaa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     eb1:	eb 04                	jmp    eb7 <strlen+0x1d>
     eb3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     eb7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     eba:	8b 45 08             	mov    0x8(%ebp),%eax
     ebd:	01 d0                	add    %edx,%eax
     ebf:	0f b6 00             	movzbl (%eax),%eax
     ec2:	84 c0                	test   %al,%al
     ec4:	75 ed                	jne    eb3 <strlen+0x19>
    ;
  return n;
     ec6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     ec9:	c9                   	leave  
     eca:	c3                   	ret    

00000ecb <memset>:

void*
memset(void *dst, int c, uint n)
{
     ecb:	55                   	push   %ebp
     ecc:	89 e5                	mov    %esp,%ebp
     ece:	e8 d1 01 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     ed3:	05 9d 0d 00 00       	add    $0xd9d,%eax
  stosb(dst, c, n);
     ed8:	8b 45 10             	mov    0x10(%ebp),%eax
     edb:	50                   	push   %eax
     edc:	ff 75 0c             	push   0xc(%ebp)
     edf:	ff 75 08             	push   0x8(%ebp)
     ee2:	e8 00 ff ff ff       	call   de7 <stosb>
     ee7:	83 c4 0c             	add    $0xc,%esp
  return dst;
     eea:	8b 45 08             	mov    0x8(%ebp),%eax
}
     eed:	c9                   	leave  
     eee:	c3                   	ret    

00000eef <strchr>:

char*
strchr(const char *s, char c)
{
     eef:	55                   	push   %ebp
     ef0:	89 e5                	mov    %esp,%ebp
     ef2:	83 ec 04             	sub    $0x4,%esp
     ef5:	e8 aa 01 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
     efa:	05 76 0d 00 00       	add    $0xd76,%eax
     eff:	8b 45 0c             	mov    0xc(%ebp),%eax
     f02:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     f05:	eb 14                	jmp    f1b <strchr+0x2c>
    if(*s == c)
     f07:	8b 45 08             	mov    0x8(%ebp),%eax
     f0a:	0f b6 00             	movzbl (%eax),%eax
     f0d:	38 45 fc             	cmp    %al,-0x4(%ebp)
     f10:	75 05                	jne    f17 <strchr+0x28>
      return (char*)s;
     f12:	8b 45 08             	mov    0x8(%ebp),%eax
     f15:	eb 13                	jmp    f2a <strchr+0x3b>
  for(; *s; s++)
     f17:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f1b:	8b 45 08             	mov    0x8(%ebp),%eax
     f1e:	0f b6 00             	movzbl (%eax),%eax
     f21:	84 c0                	test   %al,%al
     f23:	75 e2                	jne    f07 <strchr+0x18>
  return 0;
     f25:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f2a:	c9                   	leave  
     f2b:	c3                   	ret    

00000f2c <gets>:

char*
gets(char *buf, int max)
{
     f2c:	55                   	push   %ebp
     f2d:	89 e5                	mov    %esp,%ebp
     f2f:	53                   	push   %ebx
     f30:	83 ec 14             	sub    $0x14,%esp
     f33:	e8 ab fe ff ff       	call   de3 <__x86.get_pc_thunk.bx>
     f38:	81 c3 38 0d 00 00    	add    $0xd38,%ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f45:	eb 42                	jmp    f89 <gets+0x5d>
    cc = read(0, &c, 1);
     f47:	83 ec 04             	sub    $0x4,%esp
     f4a:	6a 01                	push   $0x1
     f4c:	8d 45 ef             	lea    -0x11(%ebp),%eax
     f4f:	50                   	push   %eax
     f50:	6a 00                	push   $0x0
     f52:	e8 71 01 00 00       	call   10c8 <read>
     f57:	83 c4 10             	add    $0x10,%esp
     f5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     f5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f61:	7e 33                	jle    f96 <gets+0x6a>
      break;
    buf[i++] = c;
     f63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f66:	8d 50 01             	lea    0x1(%eax),%edx
     f69:	89 55 f4             	mov    %edx,-0xc(%ebp)
     f6c:	89 c2                	mov    %eax,%edx
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	01 c2                	add    %eax,%edx
     f73:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f77:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     f79:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f7d:	3c 0a                	cmp    $0xa,%al
     f7f:	74 16                	je     f97 <gets+0x6b>
     f81:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f85:	3c 0d                	cmp    $0xd,%al
     f87:	74 0e                	je     f97 <gets+0x6b>
  for(i=0; i+1 < max; ){
     f89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f8c:	83 c0 01             	add    $0x1,%eax
     f8f:	39 45 0c             	cmp    %eax,0xc(%ebp)
     f92:	7f b3                	jg     f47 <gets+0x1b>
     f94:	eb 01                	jmp    f97 <gets+0x6b>
      break;
     f96:	90                   	nop
      break;
  }
  buf[i] = '\0';
     f97:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f9a:	8b 45 08             	mov    0x8(%ebp),%eax
     f9d:	01 d0                	add    %edx,%eax
     f9f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     fa2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     fa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fa8:	c9                   	leave  
     fa9:	c3                   	ret    

00000faa <stat>:

int
stat(const char *n, struct stat *st)
{
     faa:	55                   	push   %ebp
     fab:	89 e5                	mov    %esp,%ebp
     fad:	53                   	push   %ebx
     fae:	83 ec 14             	sub    $0x14,%esp
     fb1:	e8 2d fe ff ff       	call   de3 <__x86.get_pc_thunk.bx>
     fb6:	81 c3 ba 0c 00 00    	add    $0xcba,%ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     fbc:	83 ec 08             	sub    $0x8,%esp
     fbf:	6a 00                	push   $0x0
     fc1:	ff 75 08             	push   0x8(%ebp)
     fc4:	e8 27 01 00 00       	call   10f0 <open>
     fc9:	83 c4 10             	add    $0x10,%esp
     fcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     fcf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     fd3:	79 07                	jns    fdc <stat+0x32>
    return -1;
     fd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     fda:	eb 25                	jmp    1001 <stat+0x57>
  r = fstat(fd, st);
     fdc:	83 ec 08             	sub    $0x8,%esp
     fdf:	ff 75 0c             	push   0xc(%ebp)
     fe2:	ff 75 f4             	push   -0xc(%ebp)
     fe5:	e8 1e 01 00 00       	call   1108 <fstat>
     fea:	83 c4 10             	add    $0x10,%esp
     fed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     ff0:	83 ec 0c             	sub    $0xc,%esp
     ff3:	ff 75 f4             	push   -0xc(%ebp)
     ff6:	e8 dd 00 00 00       	call   10d8 <close>
     ffb:	83 c4 10             	add    $0x10,%esp
  return r;
     ffe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1001:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1004:	c9                   	leave  
    1005:	c3                   	ret    

00001006 <atoi>:

int
atoi(const char *s)
{
    1006:	55                   	push   %ebp
    1007:	89 e5                	mov    %esp,%ebp
    1009:	83 ec 10             	sub    $0x10,%esp
    100c:	e8 93 00 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
    1011:	05 5f 0c 00 00       	add    $0xc5f,%eax
  int n;

  n = 0;
    1016:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    101d:	eb 25                	jmp    1044 <atoi+0x3e>
    n = n*10 + *s++ - '0';
    101f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1022:	89 d0                	mov    %edx,%eax
    1024:	c1 e0 02             	shl    $0x2,%eax
    1027:	01 d0                	add    %edx,%eax
    1029:	01 c0                	add    %eax,%eax
    102b:	89 c1                	mov    %eax,%ecx
    102d:	8b 45 08             	mov    0x8(%ebp),%eax
    1030:	8d 50 01             	lea    0x1(%eax),%edx
    1033:	89 55 08             	mov    %edx,0x8(%ebp)
    1036:	0f b6 00             	movzbl (%eax),%eax
    1039:	0f be c0             	movsbl %al,%eax
    103c:	01 c8                	add    %ecx,%eax
    103e:	83 e8 30             	sub    $0x30,%eax
    1041:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	0f b6 00             	movzbl (%eax),%eax
    104a:	3c 2f                	cmp    $0x2f,%al
    104c:	7e 0a                	jle    1058 <atoi+0x52>
    104e:	8b 45 08             	mov    0x8(%ebp),%eax
    1051:	0f b6 00             	movzbl (%eax),%eax
    1054:	3c 39                	cmp    $0x39,%al
    1056:	7e c7                	jle    101f <atoi+0x19>
  return n;
    1058:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    105b:	c9                   	leave  
    105c:	c3                   	ret    

0000105d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    105d:	55                   	push   %ebp
    105e:	89 e5                	mov    %esp,%ebp
    1060:	83 ec 10             	sub    $0x10,%esp
    1063:	e8 3c 00 00 00       	call   10a4 <__x86.get_pc_thunk.ax>
    1068:	05 08 0c 00 00       	add    $0xc08,%eax
  char *dst;
  const char *src;

  dst = vdst;
    106d:	8b 45 08             	mov    0x8(%ebp),%eax
    1070:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1073:	8b 45 0c             	mov    0xc(%ebp),%eax
    1076:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1079:	eb 17                	jmp    1092 <memmove+0x35>
    *dst++ = *src++;
    107b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    107e:	8d 42 01             	lea    0x1(%edx),%eax
    1081:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1084:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1087:	8d 48 01             	lea    0x1(%eax),%ecx
    108a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    108d:	0f b6 12             	movzbl (%edx),%edx
    1090:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    1092:	8b 45 10             	mov    0x10(%ebp),%eax
    1095:	8d 50 ff             	lea    -0x1(%eax),%edx
    1098:	89 55 10             	mov    %edx,0x10(%ebp)
    109b:	85 c0                	test   %eax,%eax
    109d:	7f dc                	jg     107b <memmove+0x1e>
  return vdst;
    109f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    10a2:	c9                   	leave  
    10a3:	c3                   	ret    

000010a4 <__x86.get_pc_thunk.ax>:
    10a4:	8b 04 24             	mov    (%esp),%eax
    10a7:	c3                   	ret    

000010a8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10a8:	b8 01 00 00 00       	mov    $0x1,%eax
    10ad:	cd 40                	int    $0x40
    10af:	c3                   	ret    

000010b0 <exit>:
SYSCALL(exit)
    10b0:	b8 02 00 00 00       	mov    $0x2,%eax
    10b5:	cd 40                	int    $0x40
    10b7:	c3                   	ret    

000010b8 <wait>:
SYSCALL(wait)
    10b8:	b8 03 00 00 00       	mov    $0x3,%eax
    10bd:	cd 40                	int    $0x40
    10bf:	c3                   	ret    

000010c0 <pipe>:
SYSCALL(pipe)
    10c0:	b8 04 00 00 00       	mov    $0x4,%eax
    10c5:	cd 40                	int    $0x40
    10c7:	c3                   	ret    

000010c8 <read>:
SYSCALL(read)
    10c8:	b8 05 00 00 00       	mov    $0x5,%eax
    10cd:	cd 40                	int    $0x40
    10cf:	c3                   	ret    

000010d0 <write>:
SYSCALL(write)
    10d0:	b8 10 00 00 00       	mov    $0x10,%eax
    10d5:	cd 40                	int    $0x40
    10d7:	c3                   	ret    

000010d8 <close>:
SYSCALL(close)
    10d8:	b8 15 00 00 00       	mov    $0x15,%eax
    10dd:	cd 40                	int    $0x40
    10df:	c3                   	ret    

000010e0 <kill>:
SYSCALL(kill)
    10e0:	b8 06 00 00 00       	mov    $0x6,%eax
    10e5:	cd 40                	int    $0x40
    10e7:	c3                   	ret    

000010e8 <exec>:
SYSCALL(exec)
    10e8:	b8 07 00 00 00       	mov    $0x7,%eax
    10ed:	cd 40                	int    $0x40
    10ef:	c3                   	ret    

000010f0 <open>:
SYSCALL(open)
    10f0:	b8 0f 00 00 00       	mov    $0xf,%eax
    10f5:	cd 40                	int    $0x40
    10f7:	c3                   	ret    

000010f8 <mknod>:
SYSCALL(mknod)
    10f8:	b8 11 00 00 00       	mov    $0x11,%eax
    10fd:	cd 40                	int    $0x40
    10ff:	c3                   	ret    

00001100 <unlink>:
SYSCALL(unlink)
    1100:	b8 12 00 00 00       	mov    $0x12,%eax
    1105:	cd 40                	int    $0x40
    1107:	c3                   	ret    

00001108 <fstat>:
SYSCALL(fstat)
    1108:	b8 08 00 00 00       	mov    $0x8,%eax
    110d:	cd 40                	int    $0x40
    110f:	c3                   	ret    

00001110 <link>:
SYSCALL(link)
    1110:	b8 13 00 00 00       	mov    $0x13,%eax
    1115:	cd 40                	int    $0x40
    1117:	c3                   	ret    

00001118 <mkdir>:
SYSCALL(mkdir)
    1118:	b8 14 00 00 00       	mov    $0x14,%eax
    111d:	cd 40                	int    $0x40
    111f:	c3                   	ret    

00001120 <chdir>:
SYSCALL(chdir)
    1120:	b8 09 00 00 00       	mov    $0x9,%eax
    1125:	cd 40                	int    $0x40
    1127:	c3                   	ret    

00001128 <dup>:
SYSCALL(dup)
    1128:	b8 0a 00 00 00       	mov    $0xa,%eax
    112d:	cd 40                	int    $0x40
    112f:	c3                   	ret    

00001130 <getpid>:
SYSCALL(getpid)
    1130:	b8 0b 00 00 00       	mov    $0xb,%eax
    1135:	cd 40                	int    $0x40
    1137:	c3                   	ret    

00001138 <sbrk>:
SYSCALL(sbrk)
    1138:	b8 0c 00 00 00       	mov    $0xc,%eax
    113d:	cd 40                	int    $0x40
    113f:	c3                   	ret    

00001140 <sleep>:
SYSCALL(sleep)
    1140:	b8 0d 00 00 00       	mov    $0xd,%eax
    1145:	cd 40                	int    $0x40
    1147:	c3                   	ret    

00001148 <uptime>:
SYSCALL(uptime)
    1148:	b8 0e 00 00 00       	mov    $0xe,%eax
    114d:	cd 40                	int    $0x40
    114f:	c3                   	ret    

00001150 <random>:
SYSCALL(random)
    1150:	b8 16 00 00 00       	mov    $0x16,%eax
    1155:	cd 40                	int    $0x40
    1157:	c3                   	ret    

00001158 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1158:	55                   	push   %ebp
    1159:	89 e5                	mov    %esp,%ebp
    115b:	53                   	push   %ebx
    115c:	83 ec 14             	sub    $0x14,%esp
    115f:	e8 40 ff ff ff       	call   10a4 <__x86.get_pc_thunk.ax>
    1164:	05 0c 0b 00 00       	add    $0xb0c,%eax
    1169:	8b 55 0c             	mov    0xc(%ebp),%edx
    116c:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    116f:	83 ec 04             	sub    $0x4,%esp
    1172:	6a 01                	push   $0x1
    1174:	8d 55 f4             	lea    -0xc(%ebp),%edx
    1177:	52                   	push   %edx
    1178:	ff 75 08             	push   0x8(%ebp)
    117b:	89 c3                	mov    %eax,%ebx
    117d:	e8 4e ff ff ff       	call   10d0 <write>
    1182:	83 c4 10             	add    $0x10,%esp
}
    1185:	90                   	nop
    1186:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1189:	c9                   	leave  
    118a:	c3                   	ret    

0000118b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    118b:	55                   	push   %ebp
    118c:	89 e5                	mov    %esp,%ebp
    118e:	53                   	push   %ebx
    118f:	83 ec 24             	sub    $0x24,%esp
    1192:	e8 58 02 00 00       	call   13ef <__x86.get_pc_thunk.cx>
    1197:	81 c1 d9 0a 00 00    	add    $0xad9,%ecx
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    119d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    11a4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    11a8:	74 17                	je     11c1 <printint+0x36>
    11aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11ae:	79 11                	jns    11c1 <printint+0x36>
    neg = 1;
    11b0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    11b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ba:	f7 d8                	neg    %eax
    11bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11bf:	eb 06                	jmp    11c7 <printint+0x3c>
  } else {
    x = xx;
    11c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    11c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    11ce:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d4:	ba 00 00 00 00       	mov    $0x0,%edx
    11d9:	f7 f3                	div    %ebx
    11db:	89 d3                	mov    %edx,%ebx
    11dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11e0:	8d 50 01             	lea    0x1(%eax),%edx
    11e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11e6:	0f b6 94 19 1c 00 00 	movzbl 0x1c(%ecx,%ebx,1),%edx
    11ed:	00 
    11ee:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    11f2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f8:	ba 00 00 00 00       	mov    $0x0,%edx
    11fd:	f7 f3                	div    %ebx
    11ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1202:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1206:	75 c6                	jne    11ce <printint+0x43>
  if(neg)
    1208:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    120c:	74 2d                	je     123b <printint+0xb0>
    buf[i++] = '-';
    120e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1211:	8d 50 01             	lea    0x1(%eax),%edx
    1214:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1217:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    121c:	eb 1d                	jmp    123b <printint+0xb0>
    putc(fd, buf[i]);
    121e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1221:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1224:	01 d0                	add    %edx,%eax
    1226:	0f b6 00             	movzbl (%eax),%eax
    1229:	0f be c0             	movsbl %al,%eax
    122c:	83 ec 08             	sub    $0x8,%esp
    122f:	50                   	push   %eax
    1230:	ff 75 08             	push   0x8(%ebp)
    1233:	e8 20 ff ff ff       	call   1158 <putc>
    1238:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    123b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    123f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1243:	79 d9                	jns    121e <printint+0x93>
}
    1245:	90                   	nop
    1246:	90                   	nop
    1247:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    124a:	c9                   	leave  
    124b:	c3                   	ret    

0000124c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    124c:	55                   	push   %ebp
    124d:	89 e5                	mov    %esp,%ebp
    124f:	53                   	push   %ebx
    1250:	83 ec 24             	sub    $0x24,%esp
    1253:	e8 8b fb ff ff       	call   de3 <__x86.get_pc_thunk.bx>
    1258:	81 c3 18 0a 00 00    	add    $0xa18,%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    125e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1265:	8d 45 0c             	lea    0xc(%ebp),%eax
    1268:	83 c0 04             	add    $0x4,%eax
    126b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    126e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1275:	e9 5b 01 00 00       	jmp    13d5 <printf+0x189>
    c = fmt[i] & 0xff;
    127a:	8b 55 0c             	mov    0xc(%ebp),%edx
    127d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1280:	01 d0                	add    %edx,%eax
    1282:	0f b6 00             	movzbl (%eax),%eax
    1285:	0f be c0             	movsbl %al,%eax
    1288:	25 ff 00 00 00       	and    $0xff,%eax
    128d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1290:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1294:	75 2c                	jne    12c2 <printf+0x76>
      if(c == '%'){
    1296:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    129a:	75 0c                	jne    12a8 <printf+0x5c>
        state = '%';
    129c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    12a3:	e9 29 01 00 00       	jmp    13d1 <printf+0x185>
      } else {
        putc(fd, c);
    12a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12ab:	0f be c0             	movsbl %al,%eax
    12ae:	83 ec 08             	sub    $0x8,%esp
    12b1:	50                   	push   %eax
    12b2:	ff 75 08             	push   0x8(%ebp)
    12b5:	e8 9e fe ff ff       	call   1158 <putc>
    12ba:	83 c4 10             	add    $0x10,%esp
    12bd:	e9 0f 01 00 00       	jmp    13d1 <printf+0x185>
      }
    } else if(state == '%'){
    12c2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    12c6:	0f 85 05 01 00 00    	jne    13d1 <printf+0x185>
      if(c == 'd'){
    12cc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    12d0:	75 1e                	jne    12f0 <printf+0xa4>
        printint(fd, *ap, 10, 1);
    12d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12d5:	8b 00                	mov    (%eax),%eax
    12d7:	6a 01                	push   $0x1
    12d9:	6a 0a                	push   $0xa
    12db:	50                   	push   %eax
    12dc:	ff 75 08             	push   0x8(%ebp)
    12df:	e8 a7 fe ff ff       	call   118b <printint>
    12e4:	83 c4 10             	add    $0x10,%esp
        ap++;
    12e7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    12eb:	e9 da 00 00 00       	jmp    13ca <printf+0x17e>
      } else if(c == 'x' || c == 'p'){
    12f0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    12f4:	74 06                	je     12fc <printf+0xb0>
    12f6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    12fa:	75 1e                	jne    131a <printf+0xce>
        printint(fd, *ap, 16, 0);
    12fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12ff:	8b 00                	mov    (%eax),%eax
    1301:	6a 00                	push   $0x0
    1303:	6a 10                	push   $0x10
    1305:	50                   	push   %eax
    1306:	ff 75 08             	push   0x8(%ebp)
    1309:	e8 7d fe ff ff       	call   118b <printint>
    130e:	83 c4 10             	add    $0x10,%esp
        ap++;
    1311:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1315:	e9 b0 00 00 00       	jmp    13ca <printf+0x17e>
      } else if(c == 's'){
    131a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    131e:	75 45                	jne    1365 <printf+0x119>
        s = (char*)*ap;
    1320:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1323:	8b 00                	mov    (%eax),%eax
    1325:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1328:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    132c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1330:	75 27                	jne    1359 <printf+0x10d>
          s = "(null)";
    1332:	8d 83 cc fa ff ff    	lea    -0x534(%ebx),%eax
    1338:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while(*s != 0){
    133b:	eb 1c                	jmp    1359 <printf+0x10d>
          putc(fd, *s);
    133d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1340:	0f b6 00             	movzbl (%eax),%eax
    1343:	0f be c0             	movsbl %al,%eax
    1346:	83 ec 08             	sub    $0x8,%esp
    1349:	50                   	push   %eax
    134a:	ff 75 08             	push   0x8(%ebp)
    134d:	e8 06 fe ff ff       	call   1158 <putc>
    1352:	83 c4 10             	add    $0x10,%esp
          s++;
    1355:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1359:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135c:	0f b6 00             	movzbl (%eax),%eax
    135f:	84 c0                	test   %al,%al
    1361:	75 da                	jne    133d <printf+0xf1>
    1363:	eb 65                	jmp    13ca <printf+0x17e>
        }
      } else if(c == 'c'){
    1365:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1369:	75 1d                	jne    1388 <printf+0x13c>
        putc(fd, *ap);
    136b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    136e:	8b 00                	mov    (%eax),%eax
    1370:	0f be c0             	movsbl %al,%eax
    1373:	83 ec 08             	sub    $0x8,%esp
    1376:	50                   	push   %eax
    1377:	ff 75 08             	push   0x8(%ebp)
    137a:	e8 d9 fd ff ff       	call   1158 <putc>
    137f:	83 c4 10             	add    $0x10,%esp
        ap++;
    1382:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1386:	eb 42                	jmp    13ca <printf+0x17e>
      } else if(c == '%'){
    1388:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    138c:	75 17                	jne    13a5 <printf+0x159>
        putc(fd, c);
    138e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1391:	0f be c0             	movsbl %al,%eax
    1394:	83 ec 08             	sub    $0x8,%esp
    1397:	50                   	push   %eax
    1398:	ff 75 08             	push   0x8(%ebp)
    139b:	e8 b8 fd ff ff       	call   1158 <putc>
    13a0:	83 c4 10             	add    $0x10,%esp
    13a3:	eb 25                	jmp    13ca <printf+0x17e>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    13a5:	83 ec 08             	sub    $0x8,%esp
    13a8:	6a 25                	push   $0x25
    13aa:	ff 75 08             	push   0x8(%ebp)
    13ad:	e8 a6 fd ff ff       	call   1158 <putc>
    13b2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    13b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13b8:	0f be c0             	movsbl %al,%eax
    13bb:	83 ec 08             	sub    $0x8,%esp
    13be:	50                   	push   %eax
    13bf:	ff 75 08             	push   0x8(%ebp)
    13c2:	e8 91 fd ff ff       	call   1158 <putc>
    13c7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    13ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    13d1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    13d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13db:	01 d0                	add    %edx,%eax
    13dd:	0f b6 00             	movzbl (%eax),%eax
    13e0:	84 c0                	test   %al,%al
    13e2:	0f 85 92 fe ff ff    	jne    127a <printf+0x2e>
    }
  }
}
    13e8:	90                   	nop
    13e9:	90                   	nop
    13ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    13ed:	c9                   	leave  
    13ee:	c3                   	ret    

000013ef <__x86.get_pc_thunk.cx>:
    13ef:	8b 0c 24             	mov    (%esp),%ecx
    13f2:	c3                   	ret    

000013f3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    13f3:	55                   	push   %ebp
    13f4:	89 e5                	mov    %esp,%ebp
    13f6:	83 ec 10             	sub    $0x10,%esp
    13f9:	e8 a6 fc ff ff       	call   10a4 <__x86.get_pc_thunk.ax>
    13fe:	05 72 08 00 00       	add    $0x872,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1403:	8b 55 08             	mov    0x8(%ebp),%edx
    1406:	83 ea 08             	sub    $0x8,%edx
    1409:	89 55 f8             	mov    %edx,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    140c:	8b 90 9c 00 00 00    	mov    0x9c(%eax),%edx
    1412:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1415:	eb 24                	jmp    143b <free+0x48>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1417:	8b 55 fc             	mov    -0x4(%ebp),%edx
    141a:	8b 12                	mov    (%edx),%edx
    141c:	39 55 fc             	cmp    %edx,-0x4(%ebp)
    141f:	72 12                	jb     1433 <free+0x40>
    1421:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1424:	3b 55 fc             	cmp    -0x4(%ebp),%edx
    1427:	77 24                	ja     144d <free+0x5a>
    1429:	8b 55 fc             	mov    -0x4(%ebp),%edx
    142c:	8b 12                	mov    (%edx),%edx
    142e:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    1431:	72 1a                	jb     144d <free+0x5a>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1433:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1436:	8b 12                	mov    (%edx),%edx
    1438:	89 55 fc             	mov    %edx,-0x4(%ebp)
    143b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    143e:	3b 55 fc             	cmp    -0x4(%ebp),%edx
    1441:	76 d4                	jbe    1417 <free+0x24>
    1443:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1446:	8b 12                	mov    (%edx),%edx
    1448:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    144b:	73 ca                	jae    1417 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
    144d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1450:	8b 52 04             	mov    0x4(%edx),%edx
    1453:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
    145a:	8b 55 f8             	mov    -0x8(%ebp),%edx
    145d:	01 d1                	add    %edx,%ecx
    145f:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1462:	8b 12                	mov    (%edx),%edx
    1464:	39 d1                	cmp    %edx,%ecx
    1466:	75 24                	jne    148c <free+0x99>
    bp->s.size += p->s.ptr->s.size;
    1468:	8b 55 f8             	mov    -0x8(%ebp),%edx
    146b:	8b 4a 04             	mov    0x4(%edx),%ecx
    146e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1471:	8b 12                	mov    (%edx),%edx
    1473:	8b 52 04             	mov    0x4(%edx),%edx
    1476:	01 d1                	add    %edx,%ecx
    1478:	8b 55 f8             	mov    -0x8(%ebp),%edx
    147b:	89 4a 04             	mov    %ecx,0x4(%edx)
    bp->s.ptr = p->s.ptr->s.ptr;
    147e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1481:	8b 12                	mov    (%edx),%edx
    1483:	8b 0a                	mov    (%edx),%ecx
    1485:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1488:	89 0a                	mov    %ecx,(%edx)
    148a:	eb 0a                	jmp    1496 <free+0xa3>
  } else
    bp->s.ptr = p->s.ptr;
    148c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    148f:	8b 0a                	mov    (%edx),%ecx
    1491:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1494:	89 0a                	mov    %ecx,(%edx)
  if(p + p->s.size == bp){
    1496:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1499:	8b 52 04             	mov    0x4(%edx),%edx
    149c:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
    14a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14a6:	01 ca                	add    %ecx,%edx
    14a8:	39 55 f8             	cmp    %edx,-0x8(%ebp)
    14ab:	75 20                	jne    14cd <free+0xda>
    p->s.size += bp->s.size;
    14ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14b0:	8b 4a 04             	mov    0x4(%edx),%ecx
    14b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14b6:	8b 52 04             	mov    0x4(%edx),%edx
    14b9:	01 d1                	add    %edx,%ecx
    14bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14be:	89 4a 04             	mov    %ecx,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    14c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
    14c4:	8b 0a                	mov    (%edx),%ecx
    14c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14c9:	89 0a                	mov    %ecx,(%edx)
    14cb:	eb 08                	jmp    14d5 <free+0xe2>
  } else
    p->s.ptr = bp;
    14cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14d0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    14d3:	89 0a                	mov    %ecx,(%edx)
  freep = p;
    14d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14d8:	89 90 9c 00 00 00    	mov    %edx,0x9c(%eax)
}
    14de:	90                   	nop
    14df:	c9                   	leave  
    14e0:	c3                   	ret    

000014e1 <morecore>:

static Header*
morecore(uint nu)
{
    14e1:	55                   	push   %ebp
    14e2:	89 e5                	mov    %esp,%ebp
    14e4:	53                   	push   %ebx
    14e5:	83 ec 14             	sub    $0x14,%esp
    14e8:	e8 f6 f8 ff ff       	call   de3 <__x86.get_pc_thunk.bx>
    14ed:	81 c3 83 07 00 00    	add    $0x783,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
    14f3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    14fa:	77 07                	ja     1503 <morecore+0x22>
    nu = 4096;
    14fc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1503:	8b 45 08             	mov    0x8(%ebp),%eax
    1506:	c1 e0 03             	shl    $0x3,%eax
    1509:	83 ec 0c             	sub    $0xc,%esp
    150c:	50                   	push   %eax
    150d:	e8 26 fc ff ff       	call   1138 <sbrk>
    1512:	83 c4 10             	add    $0x10,%esp
    1515:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1518:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    151c:	75 07                	jne    1525 <morecore+0x44>
    return 0;
    151e:	b8 00 00 00 00       	mov    $0x0,%eax
    1523:	eb 27                	jmp    154c <morecore+0x6b>
  hp = (Header*)p;
    1525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1528:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    152b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    152e:	8b 55 08             	mov    0x8(%ebp),%edx
    1531:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1534:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1537:	83 c0 08             	add    $0x8,%eax
    153a:	83 ec 0c             	sub    $0xc,%esp
    153d:	50                   	push   %eax
    153e:	e8 b0 fe ff ff       	call   13f3 <free>
    1543:	83 c4 10             	add    $0x10,%esp
  return freep;
    1546:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
}
    154c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    154f:	c9                   	leave  
    1550:	c3                   	ret    

00001551 <malloc>:

void*
malloc(uint nbytes)
{
    1551:	55                   	push   %ebp
    1552:	89 e5                	mov    %esp,%ebp
    1554:	53                   	push   %ebx
    1555:	83 ec 14             	sub    $0x14,%esp
    1558:	e8 86 f8 ff ff       	call   de3 <__x86.get_pc_thunk.bx>
    155d:	81 c3 13 07 00 00    	add    $0x713,%ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1563:	8b 45 08             	mov    0x8(%ebp),%eax
    1566:	83 c0 07             	add    $0x7,%eax
    1569:	c1 e8 03             	shr    $0x3,%eax
    156c:	83 c0 01             	add    $0x1,%eax
    156f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1572:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
    1578:	89 45 f0             	mov    %eax,-0x10(%ebp)
    157b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    157f:	75 28                	jne    15a9 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    1581:	8d 83 94 00 00 00    	lea    0x94(%ebx),%eax
    1587:	89 45 f0             	mov    %eax,-0x10(%ebp)
    158a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    158d:	89 83 9c 00 00 00    	mov    %eax,0x9c(%ebx)
    1593:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
    1599:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
    base.s.size = 0;
    159f:	c7 83 98 00 00 00 00 	movl   $0x0,0x98(%ebx)
    15a6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ac:	8b 00                	mov    (%eax),%eax
    15ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    15b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b4:	8b 40 04             	mov    0x4(%eax),%eax
    15b7:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    15ba:	77 4e                	ja     160a <malloc+0xb9>
      if(p->s.size == nunits)
    15bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bf:	8b 40 04             	mov    0x4(%eax),%eax
    15c2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    15c5:	75 0c                	jne    15d3 <malloc+0x82>
        prevp->s.ptr = p->s.ptr;
    15c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ca:	8b 10                	mov    (%eax),%edx
    15cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15cf:	89 10                	mov    %edx,(%eax)
    15d1:	eb 26                	jmp    15f9 <malloc+0xa8>
      else {
        p->s.size -= nunits;
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 40 04             	mov    0x4(%eax),%eax
    15d9:	2b 45 ec             	sub    -0x14(%ebp),%eax
    15dc:	89 c2                	mov    %eax,%edx
    15de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    15e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e7:	8b 40 04             	mov    0x4(%eax),%eax
    15ea:	c1 e0 03             	shl    $0x3,%eax
    15ed:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    15f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    15f6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    15f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15fc:	89 83 9c 00 00 00    	mov    %eax,0x9c(%ebx)
      return (void*)(p + 1);
    1602:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1605:	83 c0 08             	add    $0x8,%eax
    1608:	eb 3c                	jmp    1646 <malloc+0xf5>
    }
    if(p == freep)
    160a:	8b 83 9c 00 00 00    	mov    0x9c(%ebx),%eax
    1610:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1613:	75 1e                	jne    1633 <malloc+0xe2>
      if((p = morecore(nunits)) == 0)
    1615:	83 ec 0c             	sub    $0xc,%esp
    1618:	ff 75 ec             	push   -0x14(%ebp)
    161b:	e8 c1 fe ff ff       	call   14e1 <morecore>
    1620:	83 c4 10             	add    $0x10,%esp
    1623:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1626:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    162a:	75 07                	jne    1633 <malloc+0xe2>
        return 0;
    162c:	b8 00 00 00 00       	mov    $0x0,%eax
    1631:	eb 13                	jmp    1646 <malloc+0xf5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1633:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1636:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 00                	mov    (%eax),%eax
    163e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1641:	e9 6b ff ff ff       	jmp    15b1 <malloc+0x60>
  }
}
    1646:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1649:	c9                   	leave  
    164a:	c3                   	ret    
