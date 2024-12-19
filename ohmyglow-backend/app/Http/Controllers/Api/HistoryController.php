<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\ScanHistory;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class HistoryController extends Controller
{
    // Fetch the scan history for the authenticated user
    public function index(Request $request)
    {
        $histories = ScanHistory::where('user_id', $request->user()->id)->get();
        return response()->json([
            'status' => 'success',
            'data' => $histories
        ]);
    }

    // Save a new scan history
    public function store(Request $request)
    {
        $validated = $request->validate([
            'disease_id' => 'required|integer|exists:diseases,id',
            'image_path' => 'required|string',
            'confidence_score' => 'required|numeric',
        ]);

        $scanHistory = ScanHistory::create([
            'user_id' => auth()->user->id,
            'disease_id' => $validated['disease_id'],
            'image_path' => $validated['image_path'],
            'scan_date' => Carbon::now(),
            'confidence_score' => $validated['confidence_score'],
        ]);

        return response()->json([
            'status' => 'success',
            'data' => $scanHistory
        ], 201);
    }
}
