const r4os = @import("r4os");

var engine_sends: u64 = 0;
var engine_renders: u64 = 0;
var engine_stops: u64 = 0;
var engine_last_result: i32 = 0;
var engine: r4os.abi.SynthEngine = .{};

comptime {
    asm (r4os.r4dev.driverEntriesAsm("midi_init", "midi_shutdown"));
}

export fn midi_init(api: *const r4os.r4dev.DriverApi) callconv(.c) i32 {
    var ctx = r4os.r4dev.DriverContext.init(api);
    ctx.logInfo("MIDI synth placeholder init");
    engine = .{
        .flags = r4os.abi.synth_engine_flag_midi,
        .midi_send = midiSend,
        .render = midiRender,
        .stop = midiStop,
        .status = midiStatus,
    };
    if (ctx.registerSynthEngineEx("MIDI", &engine) != 0) return -1;
    return 0;
}

export fn midi_shutdown() callconv(.c) i32 {
    return 0;
}

fn midiSend(context: ?*anyopaque, channel: u8, status: u8, data1: u8, data2: u8) callconv(.c) i32 {
    _ = context;
    _ = channel;
    _ = status;
    _ = data1;
    _ = data2;
    engine_sends +%= 1;
    engine_last_result = 0;
    return 0;
}

fn midiRender(context: ?*anyopaque) callconv(.c) i32 {
    _ = context;
    engine_renders +%= 1;
    engine_last_result = 0;
    return 0;
}

fn midiStop(context: ?*anyopaque) callconv(.c) i32 {
    _ = context;
    engine_stops +%= 1;
    engine_last_result = 0;
    return 0;
}

fn midiStatus(context: ?*anyopaque, out: *r4os.abi.SynthEngineStatus) callconv(.c) i32 {
    _ = context;
    out.* = .{
        .active = 1,
        .sends = engine_sends,
        .renders = engine_renders,
        .stops = engine_stops,
        .last_result = engine_last_result,
    };
    return 0;
}
