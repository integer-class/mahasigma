<?php

namespace App\Http\Controllers\Api;
use App\Models\Disease;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\ScanHistory;

class DiseaseController extends Controller
{
    public function identify(Request $request)
{
    $request->validate([
        'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
    ]);

    $path = $request->file('image')->store('scans', 'public');
    $result = $this->predict($path);

    ScanHistory::create([
        'user_id' => $request->user()->id,
        'image_path' => $path,
        'result' => $result,
    ]);

    return response()->json(['result' => $result]);
}

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'required',
            'treatment' => 'required',
        ]);

        return Disease::create($validated);
    }

    public function show($id)
    {
        return Disease::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $disease = Disease::findOrFail($id);
        $disease->update($request->all());
        return $disease;
    }

    public function destroy($id)
    {
        $disease = Disease::findOrFail($id);
        $disease->delete();
        return response()->json(['message' => 'Deleted successfully']);
    }
}