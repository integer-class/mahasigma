<?php

namespace App\Http\Controllers\Api;

use App\Models\Disease;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class DiseaseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $diseases = Disease::all();
        return response()->json([
            'status' => 'success',
            'data' => $diseases,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'symptoms' => 'nullable|string',
            'treatment' => 'nullable|string',
            'cause' => 'nullable|string',
            'prevention' => 'nullable|string',
            'contagious' => 'nullable|boolean',
            'risk_factors' => 'nullable|string',
            'related_diseases' => 'nullable|string',
            'references' => 'nullable|string',
        ]);

        $photoPath = $request->file('photo') ? $request->file('photo')->store('diseases', 'public') : null;

        $disease = Disease::create([
            'name' => $request->name,
            'description' => $request->description,
            'photo' => $photoPath,
            'symptoms' => $request->symptoms,
            'treatment' => $request->treatment,
            'cause' => $request->cause,
            'prevention' => $request->prevention,
            'contagious' => $request->contagious,
            'risk_factors' => $request->risk_factors,
            'related_diseases' => $request->related_diseases,
            'references' => $request->references,
        ]);

        return response()->json([
            'status' => 'success',
            'data' => $disease,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $disease = Disease::find($id);

        if (!$disease) {
            return response()->json([
                'status' => 'error',
                'message' => 'Disease not found',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $disease,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $disease = Disease::find($id);

        if (!$disease) {
            return response()->json([
                'status' => 'error',
                'message' => 'Disease not found',
            ], 404);
        }

        $request->validate([
            'name' => 'nullable|string|max:255',
            'description' => 'nullable|string',
            'photo' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'symptoms' => 'nullable|string',
            'treatment' => 'nullable|string',
            'cause' => 'nullable|string',
            'prevention' => 'nullable|string',
            'contagious' => 'nullable|boolean',
            'risk_factors' => 'nullable|string',
            'related_diseases' => 'nullable|string',
            'references' => 'nullable|string',
        ]);

        if ($request->file('photo')) {
            if ($disease->photo) {
                Storage::disk('public')->delete($disease->photo);
            }
            $photoPath = $request->file('photo')->store('diseases', 'public');
            $disease->photo = $photoPath;
        }

        $disease->update($request->except('photo'));

        return response()->json([
            'status' => 'success',
            'data' => $disease,
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $disease = Disease::find($id);

        if (!$disease) {
            return response()->json([
                'status' => 'error',
                'message' => 'Disease not found',
            ], 404);
        }

        if ($disease->photo) {
            Storage::disk('public')->delete($disease->photo);
        }

        $disease->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Disease deleted successfully',
        ]);
    }
}
