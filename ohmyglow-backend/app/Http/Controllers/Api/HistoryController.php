<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\ScanHistory;

class HistoryController extends Controller
{
    public function index(Request $request)
    {
        $histories = ScanHistory::where('user_id', $request->user()->id)->get();
        return response()->json($histories);
    }
}
