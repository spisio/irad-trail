// Simulated player for the MS-DOS edition. Load on the game page (served locally), then call
// dosBot(seed, cfg, files) or dosStats(n, makeCfg). It plays through INKEY$ and LINE INPUT like a person.
(function () {
  const D = window.IradDos;
  window.dosBot = async function (seed, cfg, sharedFs) {
    const pc = new D.EgaPC(); let b; const st = { scrollLines: [], hunts: 0, rafted: 0, shots: 0 };
    let shopQ = null, menuN = 0;
    const v = k => { for (const ty of ["!", "%", "$"]) if (b.v.has(k + ty)) return b.v.get(k + ty); return 0; };
    const a = (k, i) => { const arr = b.arr.get(k + "!"); return arr ? arr.data[i] : 0; };
    const rows = () => pc.textRows();
    const push = k => { if (!pc.keyq.length) pc.keyq.push(k); };
    pc.onScroll = () => st.scrollLines.push(b.prog[b.li] ? b.prog[b.li].num : -1);
    const io = {
      limit: cfg.limit || 4e6,
      timer: bb => (bb.vt / 1000) % 86400,
      tone() {}, play() { return 0; },
      fs: () => sharedFs, saveFs() {},
      readLine: async () => {
        const all = rows().join("\n"); let s = "";
        if (/How many would you like/.test(all)) s = String(b.__qty ?? 0);
        else if (/words for the grave/.test(all)) s = "Rest well, " + seed;
        else if (/name for the Top Ten/.test(all)) s = "Bot " + seed;
        pc.print(s); pc.putc(13); return s;
      },
      sync: async (bb) => {
        if ((bb.idle || 0) < 3 || pc.keyq.length) return;
        bb.idle = 0;
        const r = rows(), all = r.join("\n"), last = r[24] || "";
        if (/Arrows move, SPACE shoots/.test(all)) {
          let best = 0; for (let i = 1; i <= 2; i++) if (a("AKIND", i)) { best = i; break; }
          if (best && Math.random() < cfg.aim) {
            const kd = a("AKIND", best); const ax = a("AX", best) + a("AW", kd) / 2, ay = a("AY", best) + a("AH", kd) / 2; const hx = v("HUX") + 11, hy = v("HUY") + 12;
            const ang = Math.atan2(ay - hy, ax - hx); const dx = Math.round(Math.cos(ang)), dy = Math.round(Math.sin(ang));
            if (dx !== v("DX") || dy !== v("DY")) push({ "-1,-1": "\0G", "0,-1": "\0H", "1,-1": "\0I", "-1,0": "\0K", "1,0": "\0M", "-1,1": "\0O", "0,1": "\0P", "1,1": "\0Q" }[dx + "," + dy] || " ");
            else { push(" "); st.shots++; }
          } else if (Math.random() < 0.01) push("\x1b");
          return;
        }
        if (/Steer with LEFT and RIGHT/.test(all)) {
          st.rafted = 1; const rx = v("RX") + 20; let threat = null;
          for (let i = 1; i <= 4; i++) { const y = a("RKY", i), x = a("RKX", i) + 10; if (y > 70 && y < 150 && Math.abs(x - rx) < 28) threat = x; }
          if (threat !== null && Math.random() < cfg.steer) push(threat > rx ? "\0K" : "\0M");
          return;
        }
        if (/Press ENTER to continue/.test(last)) return push(String.fromCharCode(13));
        if (/Press any key to begin/.test(all)) return push(" ");
        if (/Would you like to play again/.test(all)) return push(cfg.again ? "Y" : "N");
        if (/Travel the road/.test(all) && /choice/.test(all)) return push(cfg.menuPick || "1");
        if (/biy's son/.test(all) && /choice/.test(all)) return push(String(cfg.occ));
        if (/names correct/.test(all)) return push("Y");
        if (/Ask for advice/.test(all)) return push(String(cfg.month));
        if (/Which item would you like to buy/.test(all)) {
          if (!shopQ) shopQ = v("NXTMARK") <= 1 ? cfg.buy.slice() : (v("FOOD") < 300 ? [[2, Math.max(0, Math.min(30, Math.floor((v("MONEY") - 30) / 2)))]] : []);
          const nx = shopQ.shift(); if (nx) { b.__qty = nx[1]; return push(String(nx[0])); }
          shopQ = null; return push(" ");
        }
        if (/Raft down the Naryn/.test(all)) return push(Math.random() < cfg.raft ? "1" : "2");
        if (/Pay the ferry/.test(all)) return push("2");
        if (/1 Ford it/.test(all)) { const d = v("DEPTH"); return push(d > 2.5 ? (v("MONEY") >= 5 ? "3" : "2") : d > 1.5 ? "2" : "1"); }
        if (/1 Run   2 Fight/.test(all)) return push("3");
        if (/Burn juniper|Pay him\?/.test(all)) return push("Y");
        if (/Slaughter the mare/.test(all)) return push(cfg.eatHorse ? "Y" : "N");
        if (/Will you trade/.test(all)) return push("Y");
        if (/How many days will you rest/.test(all)) return push("2");
        if (/You may:/.test(all) && /Continue on the road/.test(all)) {
          menuN++;
          if (menuN > 5) { menuN = 0; return push("1"); }
          if (/9\. Buy supplies/.test(all) && v("FOOD") < 300 && v("MONEY") > 40 && !b.__bought) { b.__bought = 1; return push("9"); }
          if (v("HP") > 60 && menuN < 3) return push("6");
          if (/Hunt for food/.test(all) && v("FOOD") < cfg.huntBelow && v("SHOTS") > 5 && menuN < 4) { st.hunts++; return push("8"); }
          if (/Talk to people/.test(all) && menuN === 1 && Math.random() < .3) return push("8");
          if (menuN === 1 && Math.random() < .1) return push(String(2 + Math.floor(Math.random() * 4)));
          menuN = 0; b.__bought = 0; return push("1");
        }
        if (/Press ENTER to size up/.test(last)) { if (v("FOOD") < cfg.huntBelow && Math.random() < 0.15) push("\r"); return; }
        if (/What is your choice/.test(all) && /Reset the Top Ten/.test(all)) return push("3");
        return push("\r");
      },
    };
    b = new D.GWBasic(pc, io); b.timer0 = 0; b.load(D.PROGRAM);
    const realSeed = b.seed.bind(b); b.seed = () => realSeed(seed * 7919 + 1);
    await b.run();
    return { err: b.error, score: v("SCORE"), over: v("OVER"), day: v("DAYNUM"), nxt: v("NXTMARK"), alive: [1, 2, 3, 4, 5].map(i => a("ALIVE", i)).filter(Boolean).length, steps: b.steps, st, tail: rows().filter(Boolean).slice(-3).join(" | ") };
  };
  window.dosStats = async function (n, mk, sharedFs) {
    const res = { n: 0, win: 0, feast: 0, errs: {}, over: {}, alive: [0, 0, 0, 0, 0, 0], days: [], scores: [], scrolls: {}, hunts: 0, rafted: 0, shots: 0 };
    for (let i = 0; i < n; i++) {
      const cfg = mk(i); const r = await window.dosBot(1000 + i, cfg, sharedFs || {}); res.n++;
      if (r.err && r.err.code !== 99) { const k = r.err.msg + "@" + r.err.line; res.errs[k] = (res.errs[k] || 0) + 1; }
      if (r.err && r.err.code === 99) { const k = "runaway@" + r.err.line; res.errs[k] = (res.errs[k] || 0) + 1; }
      for (const l of r.st.scrollLines) res.scrolls[l] = (res.scrolls[l] || 0) + 1;
      res.hunts += r.st.hunts; res.rafted += r.st.rafted; res.shots += r.st.shots;
      if (r.score > 0) { res.win++; res.days.push(r.day); if (r.day <= 236) res.feast++; res.scores.push(r.score); res.alive[r.alive]++; } else res.over[r.over] = (res.over[r.over] || 0) + 1;
      await new Promise(z => setTimeout(z, 0));
    }
    const q = x => { x.sort((a, b) => a - b); return x.length ? [x[0], x[Math.floor(x.length / 2)], x[x.length - 1]] : []; };
    res.days = q(res.days); res.scores = q(res.scores); return res;
  };
})();
